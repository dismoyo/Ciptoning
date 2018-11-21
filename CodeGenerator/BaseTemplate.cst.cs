using CodeSmith.Engine;
using SchemaExplorer;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;

namespace Generator
{
	
	public class BaseTemplate : CodeSmith.Engine.CodeTemplate
	{
        
        #region Constants
        
        private readonly string MapsDirectory = @"Maps";
        
        #endregion
		
		#region Fields
        
        private MapCollection _dbTypeMSSQLServerAliasMap;
        private MapCollection _systemCSharpAliasMap;
        private MapCollection _systemCSharpNullableMap;
        private MapCollection _systemCSharpDefaultValueMap;
         
        #endregion
        
        #region Constructors
		
		public BaseTemplate()
		{
		}
		
		#endregion
        
        #region Properties
        
        private MapCollection DbTypeMSSQLServerAliasMap
        {
            get
            {
                if (_dbTypeMSSQLServerAliasMap == null) 
                    _dbTypeMSSQLServerAliasMap = Map.Load(GetMapFileFullName("DbType-MSSQLServerAlias.csmap"));
                
                return _dbTypeMSSQLServerAliasMap;
            }
        }
        
        private MapCollection SystemCSharpAliasMap
        {
            get
            {
                if (_systemCSharpAliasMap == null) 
                    _systemCSharpAliasMap = Map.Load(GetMapFileFullName("System-CSharpAlias.csmap"));
                
                return _systemCSharpAliasMap;
            }
        }
                
        private MapCollection SystemCSharpNullableMap
        {
            get
            {
                if (_systemCSharpNullableMap == null) 
                    _systemCSharpNullableMap = Map.Load(GetMapFileFullName("System-CSharpNullable.csmap"));
                
                return _systemCSharpNullableMap;
            }
        }
        
        private MapCollection SystemCSharpDefaultValueMap
            {
            get
            {
                if (_systemCSharpDefaultValueMap == null) 
                    _systemCSharpDefaultValueMap = Map.Load(GetMapFileFullName("System-CSharpDefaultValue.csmap"));
                
                return _systemCSharpDefaultValueMap;
            }
        }
        
        #endregion
		
		#region Methods
		
		public string FormatCorrection(string name, bool camelCase)
		{
            //
			// Add correction to prefix characters here
			//

			if (name.StartsWith("@"))
				name = name.Remove(0, 1);
			
			// Validate case
			if (name == name.ToUpper())
				name = name.ToLower();
				
			name = (camelCase) ? StringUtil.ToCamelCase(name) : StringUtil.ToPascalCase(name);
			
			//
			// Add correction to unformatted abbreviations here
			//
			
			if (name.EndsWith("Id"))
				name = name.Remove(name.Length - 2) + "ID";
				
			return name;
		}
        
        
        public string FormatEnumFieldName(string name)
		{				
			return FormatEnumFieldName(name, "");
		}
        
        public string FormatEnumFieldName(string name, string prefixName)
		{				
			return string.Format("{0}{1}", prefixName, FormatPropertyName(name));
		}
		
        
        public string FormatFieldName(string name)
		{				
			return FormatCorrection(name, true);
		}
        
        public string FormatFieldValue(string name, Type type, bool nullable)
		{
            var nameValue = FormatFieldName(name);
            if (nullable && SystemCSharpNullableMap.Keys.Contains(type.FullName))
                nameValue += ".Value";
                
			return nameValue;
		}
		
        
		public string FormatProcedureParameterName(string name)
		{
			return FormatCorrection(name, false);
		}
        
        public string FormatProcedureParameterName(string name, string prefixName)
        {				
			return string.Format("{0}{1}", prefixName, FormatPropertyName(name));
		}
        
        
        public string FormatPropertyName(string name)
		{
			return FormatCorrection(name, false);
		}
        
        public string FormatPropertyValue(string name, Type type, bool nullable)
		{
            string nameValue;
            
            nameValue = FormatPropertyName(name);
            if (nullable && SystemCSharpNullableMap.Keys.Contains(type.FullName))
                nameValue += ".Value";
                
			return nameValue;
		}
		
        
		public string GenerateEnumFieldDeclarations(DataObjectBaseCollection<IDataObject> columns)
		{
			return GenerateEnumFieldDeclarations(columns, "");
		}
		
		public string GenerateEnumFieldDeclarations(DataObjectBaseCollection<IDataObject> columns, string prefixName)
		{
			return GenerateEnumFieldDeclarations(columns, prefixName, 0);
		}
		
		public string GenerateEnumFieldDeclarations(DataObjectBaseCollection<IDataObject> columns, int newLineTabCount)
		{
			return GenerateEnumFieldDeclarations(columns, "", newLineTabCount);
        }
		
        private string GenerateEnumFieldDeclarations(DataObjectBaseCollection<IDataObject> columns, string prefixName,
            int newLineTabCount)
		{
			if (prefixName == null)
				prefixName = "";
				
			var buffer = "";
			var first = true;
			foreach (IDataObject column in columns)
			{
				if (first)
					first = false;
				else
				{
					buffer += ",\n";
					for (int i = 0; i < newLineTabCount; i++)
						buffer += "\t";
				}
					
				buffer += FormatEnumFieldName(column.Name, prefixName);
			}
			
			return buffer;
		}
		
        
		public string GenerateFieldComparations(DataObjectBaseCollection<IDataObject> columns, string objectName)
		{
			return GenerateFieldComparations(columns, "", objectName);
		}
		
		public string GenerateFieldComparations(DataObjectBaseCollection<IDataObject> columns, string prefixName,
            string objectName)
		{
			return GenerateFieldComparations(columns, prefixName, objectName, 0);
		}
		
		public string GenerateFieldComparations(DataObjectBaseCollection<IDataObject> columns, string objectName,
            int newLineTabCount)
		{
			return GenerateFieldComparations(columns, "", objectName, newLineTabCount);
		}
        
        private string GenerateFieldComparations(DataObjectBaseCollection<IDataObject> columns, string prefixName,
            string objectName, int newLineTabCount)
		{
			if (prefixName == null)
				prefixName = "";
				
			var buffer = "";
			var first = true;
			foreach (IDataObject column in columns)
			{
				if (first)
					first = false;
				else
				{
					buffer += " &&\n";
					for (int i = 0; i < newLineTabCount; i++)
						buffer += "\t";
				}
					
				buffer += string.Format("{0}{1}.Equals({2}.{0}{1})", prefixName,
                    FormatFieldName(column.Name), objectName);
			}
			
			return buffer;
		}
				
        
        public string GenerateParameters(DataObjectBaseCollection<IDataObject> columns, string prefixName,
            bool declaration, bool refDeclaration)
		{
			if (prefixName == null)
				prefixName = "";
				
			var buffer = "";
			var first = true;
			foreach (IDataObject column in columns)
			{
				if (first)
					first = false;
				else
					buffer += ", ";
					
				buffer += string.Format((declaration) ? "{0}{1} {2}{3}" : (((prefixName == "") ? "this." : "") + "{2}{3}"),
					(refDeclaration) ? "ref " : "", GetSystemTypeString(column.SystemType, column.AllowDBNull), prefixName,
                    (prefixName == "") ? FormatFieldName(column.Name) : FormatPropertyName(column.Name));
			}
			
			return buffer;
		}
		
        
        public string GenerateRefParameterDeclarations(DataObjectBaseCollection<IDataObject> columns)
		{
			return GenerateRefParameterDeclarations(columns, "");
		}
        
        public string GenerateRefParameterDeclarations(DataObjectBaseCollection<IDataObject> columns, string prefixName)
		{
			return GenerateParameters(columns, prefixName, true, true);
		}
        
		public string GenerateParameterDeclarations(DataObjectBaseCollection<IDataObject> columns)
		{			
			return GenerateParameterDeclarations(columns, "");
		}
        
        public string GenerateParameterDeclarations(DataObjectBaseCollection<IDataObject> columns, string prefixName)
		{
			return GenerateParameters(columns, prefixName, true, false);
		}
		
		public string GenerateParameterDeclarations(DataObjectBaseCollection<IDataObject> inputColumns,
            DataObjectBaseCollection<IDataObject> outputColumns)
		{			
			return GenerateParameterDeclarations(inputColumns, outputColumns, "");
		}
		
		public string GenerateParameterDeclarations(DataObjectBaseCollection<IDataObject> inputColumns,
            DataObjectBaseCollection<IDataObject> outputColumns, string prefixName)
		{
			var input = GenerateParameterDeclarations(inputColumns, prefixName);
			var output = GenerateRefParameterDeclarations(outputColumns, prefixName);
			return input + ((!string.IsNullOrEmpty(output)) ? (", " + output) : "");
		}
        
        
		public string GeneratePropertyComparations(DataObjectBaseCollection<IDataObject> columns, string objectName)
		{
			return GeneratePropertyComparations(columns, "", objectName);
		}
		
		public string GeneratePropertyComparations(DataObjectBaseCollection<IDataObject> columns, string prefixName,
            string objectName)
		{
			return GeneratePropertyComparations(columns, prefixName, objectName, 0);
		}
		
		public string GeneratePropertyComparations(DataObjectBaseCollection<IDataObject> columns, string prefixName,
            string objectName, int newLineTabCount)
		{
			if (prefixName == null)
				prefixName = "";
				
			var buffer = "";
			var first = true;
			foreach (IDataObject column in columns)
			{
				if (first)
					first = false;
				else
				{
					buffer += " &&\n";
					for (int i = 0; i < newLineTabCount; i++)
						buffer += "\t";
				}
					
				buffer += string.Format("{0}{1}.Equals({2}.{0}{1})", prefixName,
                    FormatPropertyName(column.Name), objectName);
			}
			
			return buffer;
		}
		
        
        public string GenerateRefPassingParameters(DataObjectBaseCollection<IDataObject> columns)
		{
			return GenerateRefPassingParameters(columns, "");
		}
        
        public string GenerateRefPassingParameters(DataObjectBaseCollection<IDataObject> columns, string prefixName)
		{
			return GenerateParameters(columns, prefixName, false, true);
		}
        
        public string GeneratePassingParameters(DataObjectBaseCollection<IDataObject> columns)
		{
			return GeneratePassingParameters(columns, "");
		}
        
        public string GeneratePassingParameters(DataObjectBaseCollection<IDataObject> columns, string prefixName)
		{
			return GenerateParameters(columns, prefixName, false, false);
		}
        
        public string GeneratePassingParameters(DataObjectBaseCollection<IDataObject> inputColumns,
            DataObjectBaseCollection<IDataObject> outputColumns)
		{			
			return GeneratePassingParameters(inputColumns, outputColumns, "");
		}
		
		public string GeneratePassingParameters(DataObjectBaseCollection<IDataObject> inputColumns,
            DataObjectBaseCollection<IDataObject> outputColumns, string prefixName)
		{			
			var input = GeneratePassingParameters(inputColumns, prefixName);
			var output = GenerateRefPassingParameters(outputColumns, prefixName);
			return input + ((!string.IsNullOrEmpty(output)) ? (", " + output) : "");
		}
                	
        
        public string GenerateParameterInitValues(DataObjectBaseCollection<IDataObject> columns)
		{
			var buffer = "";
			var first = true;
			foreach (IDataObject column in columns)
			{
				if (first)
					first = false;
				else
					buffer += ", ";
					
				buffer += GetInitValueString(column.SystemType);
			}
			
			return buffer;
		}
        
        
		public string GetInitValueString(Type type)
		{
			if (type.Equals(typeof(short)) || type.Equals(typeof(ushort)) ||
                type.Equals(typeof(int)) || type.Equals(typeof(uint)) ||
				type.Equals(typeof(long)) || type.Equals(typeof(ulong)) ||
                type.Equals(typeof(char)) ||
                type.Equals(typeof(byte)) || type.Equals(typeof(sbyte)))
				return "0";
			else if (type.Equals(typeof(float)))
				return "0F";
			else if (type.Equals(typeof(double)))
				return "0D";
			else if (type.Equals(typeof(string)))
				return "\"\"";
				
			return "null";
		}
		
        
        public string GetSystemTypeDefaultValueString(string typeFullName, bool nullable)
		{
            var type = Type.GetType(typeFullName);            
            if (type != null)
            {
                var value = GetSystemTypeDefaultValueString(type, nullable);
                if (value != null)
                    return value;
            }
            
            return string.Format("new {0}()", typeFullName);
		}
        
        public string GetSystemTypeDefaultValueString(Type type, bool nullable)
		{
            if (nullable)
                return "null";
            
            if (SystemCSharpDefaultValueMap.Keys.Contains(type.FullName))
                return SystemCSharpDefaultValueMap[type.FullName];
                
			return "null";
		}
        
        public string GetSystemTypeString(string typeFullName, bool nullable)
		{
            var type = Type.GetType(typeFullName);            
            if (type != null)
                return GetSystemTypeString(type, nullable);
            
            return typeFullName;
		}
        
		public string GetSystemTypeString(Type type, bool nullable)
		{
            return GetSystemTypeString(SystemCSharpAliasMap, SystemCSharpNullableMap, type, nullable);
		}
        
        public string GetSystemTypeString(MapCollection map, MapCollection nullableMap, string typeFullName, bool nullable)
		{
            var type = Type.GetType(typeFullName);            
            if (type != null)
                return GetSystemTypeString(map, nullableMap, type, nullable);
            
            return typeFullName;
		}
        
        public string GetSystemTypeString(MapCollection map, MapCollection nullableMap, Type type, bool nullable)
		{
            if (nullable && map.Keys.Contains(type.FullName))
                return nullableMap[type.FullName];
            
            return map[type.FullName];
		}
                
        public string GetDbTypeString(IDataObject column)
		{            
            return string.Format(DbTypeMSSQLServerAliasMap[string.Format("{0}.{1}", column.DataType.GetType().FullName,
                column.DataType.ToString())], column.Size, column.Precision, column.Scale);
		}
        
        
        public string RemoveBrackets(string name)
        {
            return name.Replace("[", "").Replace("]", "");
        }
        
        public void AddTableAliasAbbreviation(Dictionary<string, string[]> tableAliases,
            string refColumnName, string tableName)
        {
            string tableAlias = GetAbbreviation(RemoveBrackets(tableName));            
            if (tableAlias.Equals(string.Empty))
                tableAlias = "T";
            
            int counter = 2;
            string temp = tableAlias;
            while (tableAliases.Values.Where(p => p[1] == temp).Count() > 0)
            {
                temp = tableAlias + counter.ToString();
                counter++;
            }
            
            tableAlias = temp;
            tableAliases.Add(refColumnName, new string[] { tableName, tableAlias });
        }
        
        public string GetAbbreviation(string name)
        {
            string abbr = "";
            foreach (char c in name)
            {
                if ((c >= 'A') && (c <= 'Z'))
                    abbr += c.ToString();
            }
            
            return abbr;
        }
        
        
        
        public string GetMapFileFullName(string fileName)
        {
            string currentMapsDirectory = Directory.GetCurrentDirectory() + @"\" + MapsDirectory;
            
            return string.Format(@"{0}\{1}", (Directory.Exists(currentMapsDirectory)) ? currentMapsDirectory :
                (new FileInfo(CodeTemplateInfo.CodeBehind).DirectoryName + @"\" + MapsDirectory), fileName);
        }
        
		#endregion
		
	}
	
}
