using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;

namespace Dismoyo.Utilities
{

    public static class AsyncUtility
    {

        #region Classes

        private class ExclusiveSynchronizationContext : SynchronizationContext
        {

            #region Fields

            private bool completed;
            private readonly AutoResetEvent workItemsWaiting = new AutoResetEvent(false);
            private readonly Queue<Tuple<SendOrPostCallback, object>> items =
                new Queue<Tuple<SendOrPostCallback, object>>();

            #endregion

            #region Properties

            public Exception InnerException { get; set; }

            #endregion

            #region Methods

            public override void Send(SendOrPostCallback d, object state)
            {
                throw new NotSupportedException("Send to the same thread is not allowed.");
            }

            public override void Post(SendOrPostCallback d, object state)
            {
                lock (items)
                {
                    items.Enqueue(Tuple.Create(d, state));
                }

                workItemsWaiting.Set();
            }

            public void EndMessageLoop()
            {
                Post(p => completed = true, null);
            }

            public void BeginMessageLoop()
            {
                while (!completed)
                {
                    Tuple<SendOrPostCallback, object> task = null;
                    lock (items)
                    {
                        if (items.Count > 0)
                            task = items.Dequeue();
                    }

                    if (task != null)
                    {
                        task.Item1(task.Item2);
                        if (InnerException != null)
                            throw new AggregateException("AsyncHelpers.Run method threw an exception.", InnerException);                        
                    }
                    else
                        workItemsWaiting.WaitOne();
                }
            }

            public override SynchronizationContext CreateCopy()
            {
                return this;
            }

            #endregion

        }

        #endregion

        #region Methods

        /// <summary>
        /// Execute's an async Task<T> method which has a void return value synchronously.
        /// </summary>
        /// <param name="task">Task<T> method to execute</param>
        public static void RunSync(Func<Task> task)
        {
            var oldContext = SynchronizationContext.Current;
            var sync = new ExclusiveSynchronizationContext();
            SynchronizationContext.SetSynchronizationContext(sync);

            sync.Post(async p =>
            {
                try
                {
                    await task();
                }
                catch (Exception e)
                {
                    sync.InnerException = e;
                    throw;
                }
                finally
                {
                    sync.EndMessageLoop();
                }
            }, null);

            sync.BeginMessageLoop();
            SynchronizationContext.SetSynchronizationContext(oldContext);
        }

        /// <summary>
        /// Execute's an async Task<T> method which has a T return type synchronously.
        /// </summary>
        /// <typeparam name="T">Return Type</typeparam>
        /// <param name="task">Task<T> method to execute</param>
        /// <returns></returns>
        public static T RunSync<T>(Func<Task<T>> task)
        {
            var oldContext = SynchronizationContext.Current;
            var sync = new ExclusiveSynchronizationContext();
            SynchronizationContext.SetSynchronizationContext(sync);
            T ret = default(T);

            sync.Post(async p =>
            {
                try
                {
                    ret = await task();
                }
                catch (Exception e)
                {
                    sync.InnerException = e;
                    throw;
                }
                finally
                {
                    sync.EndMessageLoop();
                }
            }, null);

            sync.BeginMessageLoop();
            SynchronizationContext.SetSynchronizationContext(oldContext);
            return ret;
        }
        
        #endregion

    }

}
