variable "mssql_databases" {
  description = "A map of MSSQL database configurations."
  type = map(object({
    name       = string
    server_key = string   # <-- ADD THIS
  }))   
}

variable "mssql_server_fetch" {
  description = "A map of MSSQL server fetch configurations."
  type = map(object({
    sql_server_name      = string
    resource_group_name  = string
  }))   
}
