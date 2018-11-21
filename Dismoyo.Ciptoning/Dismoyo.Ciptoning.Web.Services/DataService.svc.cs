using Dismoyo.Ciptoning.Data;
using Dismoyo.Ciptoning.Web.Security;
using Dismoyo.Utilities;
using Microsoft.Data.Edm;
using Microsoft.Data.Edm.Csdl;
using Microsoft.Data.OData.Query;
using Microsoft.Data.OData.Query.SemanticAst;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Data.Services;
using System.Data.Services.Common;
using System.Data.Services.Providers;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.ServiceModel;
using System.Text;
using System.Web;
using System.Xml;

namespace Dismoyo.Ciptoning.Web.Services
{

#if DEBUG
    [ServiceBehavior(IncludeExceptionDetailInFaults = true)]
#endif
    [JSONPSupportBehavior]
    public partial class DataService : EntityFrameworkDataService<StoreFunctionsDataContext>, IServiceProvider
    {

        #region Classes

        public class OverwriteMethodInfo
        {

            #region Constructors

            public OverwriteMethodInfo(string rawMethodName, string rewrittenMethodName, Type entityType)
            {
                RawMethodName = rawMethodName;
                OverwrittenMethodName = rewrittenMethodName;
                EntityType = entityType;
            }

            #endregion

            #region Properties

            public string RawMethodName { get; private set; }
            public string OverwrittenMethodName { get; private set; }
            public Type EntityType { get; private set; }

            #endregion

        }

        #endregion

        #region Properties

        public static readonly string DataServiceName = "DataService.svc";

        public static OverwriteMethodInfo[] OverwrittenMethods = new OverwriteMethodInfo[]
        {
            new OverwriteMethodInfo("vSites", "fSites", typeof(vSite)),
            new OverwriteMethodInfo("vCustomers", "fCustomers", typeof(vCustomer)),

            new OverwriteMethodInfo("vStockViews", "fStockViews", typeof(vStockView)),
            new OverwriteMethodInfo("vStockOpnames", "fStockOpnames", typeof(vStockOpname)),
            new OverwriteMethodInfo("vStockOpnameSummaries", "fStockOpnameSummaries", typeof(vStockOpnameSummary)),
            new OverwriteMethodInfo("vStockOpnameDetails", "fStockOpnameDetails", typeof(vStockOpnameDetails)),

            new OverwriteMethodInfo("vStockChanges", "fStockChanges", typeof(vStockChanges)),
            new OverwriteMethodInfo("vStockChangesSummaries", "fStockChangesSummaries", typeof(vStockChangesSummary)),
            new OverwriteMethodInfo("vStockChangesDetails", "fStockChangesDetails", typeof(vStockChangesDetails)),

            new OverwriteMethodInfo("vStockTransfers", "fStockTransfers", typeof(vStockTransfer)),
            new OverwriteMethodInfo("vStockTransferSummaries", "fStockTransferSummaries", typeof(vStockTransferSummary)),
            new OverwriteMethodInfo("vStockTransferDetails", "fStockTransferDetails", typeof(vStockTransferDetails)),

            new OverwriteMethodInfo("vStockDisposals", "fStockDisposals", typeof(vStockDisposal)),
            new OverwriteMethodInfo("vStockDisposalSummaries", "fStockDisposalSummaries", typeof(vStockDisposalSummary)),
            new OverwriteMethodInfo("vStockDisposalDetails", "fStockDisposalDetails", typeof(vStockDisposalDetails)),

            new OverwriteMethodInfo("vStockReceives", "fStockReceives", typeof(vStockReceive)),
            new OverwriteMethodInfo("vStockReceiveSummaries", "fStockReceiveSummaries", typeof(vStockReceiveSummary)),
            new OverwriteMethodInfo("vStockReceiveDetails", "fStockReceiveDetails", typeof(vStockReceiveDetails)),

            new OverwriteMethodInfo("vSalesOrders", "fSalesOrders", typeof(vSalesOrder)),
            new OverwriteMethodInfo("vSalesOrderSummaries", "fSalesOrderSummaries", typeof(vSalesOrderSummary)),
            new OverwriteMethodInfo("vSalesOrderDetails", "fSalesOrderDetails", typeof(vSalesOrderDetails)),

            new OverwriteMethodInfo("vSalesOrderReturns", "fSalesOrderReturns", typeof(vSalesOrderReturn)),
            new OverwriteMethodInfo("vSalesOrderReturnSummaries", "fSalesOrderReturnSummaries", typeof(vSalesOrderReturnSummary)),
            new OverwriteMethodInfo("vSalesOrderReturnDetails", "fSalesOrderReturnDetails", typeof(vSalesOrderReturnDetails)),

            new OverwriteMethodInfo("vSalesOrderSwaps", "fSalesOrderSwaps", typeof(vSalesOrderSwap)),
            new OverwriteMethodInfo("vSalesOrderSwapSummaries", "fSalesOrderSwapSummaries", typeof(vSalesOrderSwapSummary)),
            new OverwriteMethodInfo("vSalesOrderSwapDetails", "fSalesOrderSwapDetails", typeof(vSalesOrderSwapDetails)),

            new OverwriteMethodInfo("vSalesOrderSamples", "fSalesOrderSamples", typeof(vSalesOrderSample)),
            new OverwriteMethodInfo("vSalesOrderSampleSummaries", "fSalesOrderSampleSummaries", typeof(vSalesOrderSampleSummary)),
            new OverwriteMethodInfo("vSalesOrderSampleDetails", "fSalesOrderSampleDetails", typeof(vSalesOrderSampleDetails)),

            new OverwriteMethodInfo("vSalesOrderFOCs", "fSalesOrderFOCs", typeof(vSalesOrderFOC)),
            new OverwriteMethodInfo("vSalesOrderFOCSummaries", "fSalesOrderFOCSummaries", typeof(vSalesOrderFOCSummary)),
            new OverwriteMethodInfo("vSalesOrderFOCDetails", "fSalesOrderFOCDetails", typeof(vSalesOrderFOCDetails)),

            new OverwriteMethodInfo("vRoutePlans", "fRoutePlans", typeof(vRoutePlan)),
            new OverwriteMethodInfo("vRoutePlanSalesmen", "fRoutePlanSalesmen", typeof(vRoutePlanSalesman)),
            new OverwriteMethodInfo("vRoutePlanCustomers", "fRoutePlanCustomers", typeof(vRoutePlanCustomer)),

            new OverwriteMethodInfo("vSFADashboards", "fSFADashboards", typeof(vSFADashboard)),
            new OverwriteMethodInfo("vSFADashboardDetails", "fSFADashboardDetails", typeof(vSFADashboardDetails))
        };

        protected DataServiceOperationContext OperationContext { get; private set; }
        protected static IEdmModel CurrentModel { get; private set; }
        protected OverwriteMethodInfo CurrentOverwrittenMethod { get; private set; }
        protected Dictionary<string, string> QueryParameters { get; private set; }
        protected Dictionary<string, object> FilterParameters { get; private set; }

        #endregion

        #region Methods

        // This method is called only once to initialize service-wide policies.
        public static void InitializeService(DataServiceConfiguration config)
        {
            // TODO: set rules to indicate which entity sets and service operations are visible, updatable, etc.
            // Examples:
            config.SetEntitySetAccessRule("*", EntitySetRights.All);
            config.DataServiceBehavior.MaxProtocolVersion = DataServiceProtocolVersion.V3;
            config.DisableValidationOnMetadataWrite = true;

            foreach (var method in DataService.OverwrittenMethods)
                config.SetServiceOperationAccessRule(method.OverwrittenMethodName, ServiceOperationRights.AllRead);

#if DEBUG
            config.UseVerboseErrors = true;
#endif
        }

        public static bool ValidateSegment(string absolutePath, string methodName)
        {
            string serviceName = "/" + DataServiceName + "/" + methodName;

            string path = absolutePath;
            int index = absolutePath.IndexOf(serviceName);
            if (index >= 0)
                path = path.Substring(index);

            index = path.IndexOf("(");
            if (index >= 0)
                path = path.Substring(0, index);

            return path.Equals(serviceName, StringComparison.OrdinalIgnoreCase);
        }

        public static void OverwriteMethods(HttpContext context)
        {
            foreach (var method in OverwrittenMethods)
            {
                string serviceAbsolutePath = "/" + DataServiceName + "/";
                if (context.Request.HttpMethod.Equals("GET", StringComparison.OrdinalIgnoreCase) &&
                    ValidateSegment(HttpUtility.UrlDecode(context.Request.Url.AbsolutePath),
                    method.RawMethodName))
                {
                    HttpContext.Current.RewritePath(HttpUtility.UrlDecode(HttpContext.Current.Request.RawUrl).Replace(
                        serviceAbsolutePath + method.RawMethodName, serviceAbsolutePath + method.OverwrittenMethodName));
                    break;
                }
            }
        }



        protected override void OnStartProcessingRequest(ProcessRequestArgs args)
        {
            OperationContext = args.OperationContext;

            CurrentOverwrittenMethod = OverwrittenMethods.SingleOrDefault(p => ValidateSegment(p.OverwrittenMethodName));
            if (CurrentOverwrittenMethod != null)
                CurrentModel = Microsoft.Data.Edm.Csdl.EdmxReader.Parse(XmlReader.Create(HttpUtility.UrlDecode(
                    args.ServiceUri.AbsoluteUri) + "$metadata"));

            QueryParameters = GetQueryParameterBag(OperationContext);

            if (ValidateSegment("$metadata") || (CurrentOverwrittenMethod != null) || AuthService.Authorize())
            {
                FilterParameters = GetQueryFilterParameter(args);

                PropertyInfo isreadonly = typeof(System.Collections.Specialized.NameValueCollection)
                    .GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
                isreadonly.SetValue(HttpContext.Current.Request.QueryString, false, null);
                HttpContext.Current.Request.QueryString.Remove("$filter");

                base.OnStartProcessingRequest(args);
                return;
            }

            throw new DataServiceException(401, "Invalid user name or password");
        }

        

        protected virtual Dictionary<string, string> GetQueryParameterBag(
            DataServiceOperationContext serviceOperationContext)
        {
            var parameterBag = new Dictionary<string, string>();
            string query = HttpUtility.UrlDecode(serviceOperationContext.AbsoluteRequestUri.Query);
            if (!string.IsNullOrEmpty(query))
            {
                query = query.Remove(0, 1);

                string paramName;
                string paramValue;
                foreach (var item in query.Split('&'))
                {
                    if (item.StartsWith("$"))
                    {
                        var equalIndex = item.IndexOf("=");
                        paramName = item.Substring(0, equalIndex);
                        paramValue = item.Substring(equalIndex + 1);
                        parameterBag.Add(paramName, paramValue);
                    }
                }
            }

            return parameterBag;
        }

        protected object GetQueryFilterParameterValue(string parameterName)
        {
            if (FilterParameters.ContainsKey(parameterName))
                return FilterParameters[parameterName];

            return null;
        }

        protected virtual bool ValidateSegment(string methodName)
        {
            return ValidateSegment(HttpUtility.UrlDecode(OperationContext.AbsoluteRequestUri.AbsolutePath), methodName);
        }

        protected virtual void CancelChanges()
        {
            if (CurrentDataSource.ChangeTracker.HasChanges())
            {
                foreach (DbEntityEntry entry in CurrentDataSource.ChangeTracker.Entries())
                {
                    switch (entry.State)
                    {
                        case EntityState.Added:
                            entry.State = EntityState.Detached;
                            break;
                        case EntityState.Modified:
                            entry.State = EntityState.Unchanged;
                            break;
                        case EntityState.Deleted:
                            entry.Reload();
                            break;
                        default: break;
                    }
                }
            }
        }



        private Dictionary<string, object> GetQueryFilterParameter(ProcessRequestArgs args)
        {
            var filterParameters = new Dictionary<string, object>();

            if (CurrentOverwrittenMethod != null)
            {
                var uriParser = new ODataUriParser(CurrentModel, args.ServiceUri);

                foreach (var segment in uriParser.ParsePath(args.RequestUri).ToList())
                {
                    if (segment is KeySegment)
                    {
                        foreach (var item in ((KeySegment)segment).Keys)
                            filterParameters.Add(item.Key, item.Value);
                    }
                }

                if (QueryParameters.ContainsKey("$filter"))
                {
                    var filter = ODataUriParser.ParseFilter(QueryParameters["$filter"], uriParser.Model,
                        uriParser.Model.FindType(CurrentOverwrittenMethod.EntityType.FullName));

                    LoadFilterParameters(filterParameters, filter.Expression);
                }
            }

            return filterParameters;
        }

        private void LoadFilterParameters(Dictionary<string, object> filterParameters, SingleValueNode node)
        {
            if ((node != null) && (node.Kind == QueryNodeKind.BinaryOperator))
            {
                var binaryNode = (BinaryOperatorNode)node;
                SingleValuePropertyAccessNode propNode = null;
                ConvertNode convertNode = null;
                ConstantNode constantNode = null;

                switch (binaryNode.Left.Kind)
                {
                    case QueryNodeKind.BinaryOperator:
                        LoadFilterParameters(filterParameters, binaryNode.Left);
                        break;
                    case QueryNodeKind.SingleValuePropertyAccess:
                        propNode = (SingleValuePropertyAccessNode)binaryNode.Left;
                        break;
                    case QueryNodeKind.Convert:
                        convertNode = (ConvertNode)binaryNode.Left;
                        break;
                    case QueryNodeKind.Constant:
                        constantNode = (ConstantNode)binaryNode.Left;
                        break;
                }

                switch (binaryNode.Right.Kind)
                {
                    case QueryNodeKind.BinaryOperator:
                        LoadFilterParameters(filterParameters, binaryNode.Right);
                        break;
                    case QueryNodeKind.SingleValuePropertyAccess:
                        propNode = (SingleValuePropertyAccessNode)binaryNode.Right;
                        break;
                    case QueryNodeKind.Convert:
                        convertNode = (ConvertNode)binaryNode.Right;
                        break;
                    case QueryNodeKind.Constant:
                        constantNode = (ConstantNode)binaryNode.Right;
                        break;
                }

                if (convertNode != null)
                {
                    switch (convertNode.Source.Kind)
                    {
                        case QueryNodeKind.SingleValuePropertyAccess:
                            propNode = (SingleValuePropertyAccessNode)convertNode.Source;
                            break;
                        case QueryNodeKind.Constant:
                            constantNode = (ConstantNode)convertNode.Source;
                            break;
                        default:
                            LoadFilterParameters(filterParameters, convertNode.Source);
                            break;
                    }
                }

                if ((propNode != null) && (constantNode != null))
                {
                    if (filterParameters.ContainsKey(propNode.Property.Name))
                        filterParameters[propNode.Property.Name] = constantNode.Value;
                    else
                        filterParameters.Add(propNode.Property.Name, constantNode.Value);
                }
            }
        }

        #endregion


        #region Implements IServiceProvider

        public object GetService(Type serviceType)
        {
            if (serviceType == typeof(IDataServiceStreamProvider))
                return new ImageStreamProvider(); // Return the stream provider to the data service.

            return null;
        }


        protected override void HandleException(HandleExceptionArgs args)
        {
            using (EventLog eventLog = new EventLog("Application"))
            {
                eventLog.Source = "Application";
                eventLog.WriteEntry("iDOS 2.0: " + ExceptionUtility.InnermostException(args.Exception).Message, EventLogEntryType.Information, 101, 1);
            }


            args.Exception = ExceptionUtility.InnermostException(args.Exception);
            if (args.Exception.Message.Contains("duplicate key"))
            {
                args.Exception = new Exception("The data you want to add is already exists.");
            }

            base.HandleException(args);
        }

        #endregion

    }

}
