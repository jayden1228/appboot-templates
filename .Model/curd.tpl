package {{.PackageName}}
import (
	gdb "gitlab.com/makeblock-go/mysql"
)

{{.TableComment}}
type {{.StructName}} struct {
{{range $j, $item := .Fields}}{{$item.Name}}	{{$item.Type}}	{{$item.FormatFields}}	{{$item.Remark}} 
{{end}}
}

var {{.StructName}}Default {{.StructName}}

// Table is function set the ORM database name
func (c *{{.StructName}})TableName() string {
	return "{{.TableName}}"
}

// Create is a function to create a single record to table
func (c *{{.StructName}}) Create() ({{range $item := .Fields}} {{ if $item.PrimaryKey }}{{$item.Name}} {{$item.Type}}{{end}}{{end -}}, err error) {
    db := gdb.GetDB().Create(c)
	if err = db.Error; err != nil {
	    return -1, err
	}
	return c.{{range $item := .Fields}} {{ if $item.PrimaryKey }}{{$item.Name}}{{end}}{{end -}}, nil
}

// DeleteById is a function to delete a single record from table
func (c *{{.StructName}}) DeleteById({{range $item := .Fields}} {{ if $item.PrimaryKey }}{{$item.Name}} {{$item.Type}}{{end}}{{end -}}) error {
   	return gdb.GetDB().Table(c.TableName()).Delete({{.StructName}}{}, "{{range $item := .Fields}} {{ if $item.PrimaryKey }}{{$item.DbOriField}}{{end}}{{end -}} = ?", {{range $item := .Fields}} {{ if $item.PrimaryKey }}{{$item.Name}}{{end}}{{end -}}).Error
}

// Update is a function to update record with specific field with data map to table
func (c *{{.StructName}}) Update({{range $item := .Fields}}{{ if $item.PrimaryKey }}{{$item.Name}} {{$item.Type}}{{end}}{{end -}}, data map[string]interface{}) (RowsAffected int64, err error) {
   db := gdb.GetDB().Table(c.TableName()).Where("{{range $item := .Fields}} {{ if $item.PrimaryKey }}{{$item.DbOriField}}{{end}}{{end -}} = ?", {{range $item := .Fields}} {{ if $item.PrimaryKey }}{{$item.Name}}{{end}}{{end -}}).Update(data)
   return db.RowsAffected, db.Error
}

// Save is a function to update record with all field with struct to table 
func (c *{{.StructName}}) Save() (rowsAffected int64, err error) {
	db := gdb.GetDB().Save(c)
	return db.RowsAffected, db.Error
}

// GetById is a function to get a single record from the table
func (c *{{.StructName}})GetById({{range $item := .Fields}}{{ if $item.PrimaryKey }}{{$item.Name}} {{$item.Type}}{{end}}{{end -}}) (*{{.StructName}}, error) {
	var result {{.StructName}}
	if err := gdb.GetDB().First(&result, {{range $item := .Fields}}{{ if $item.PrimaryKey }}{{$item.Name}},{{end}}{{end -}}).Error; err != nil {
			return nil, err
	}
	return &result, nil
}

// GetList is a function to get a slice of record(s) from {{.TableName}} table
// params - page     - page requested (defaults to 0)
// params - pageSize - number of records in a page  (defaults to 20)
// params - order    - db sort order column
func (c *{{.StructName}})GetList(page, pageSize int64, order string) (results []*{{.StructName}}, totalRows int, err error) {

	resultOrm := gdb.GetDB().Model(&{{.StructName}}{})
    resultOrm.Count(&totalRows)

	if page > 0 {
		offset := (page - 1) * pageSize
		resultOrm = resultOrm.Offset(offset).Limit(pageSize)
	} else {
		resultOrm = resultOrm.Limit(pageSize)
    }

	if order != "" {
		resultOrm = resultOrm.Order(order)
	}

	if err = resultOrm.Find(&results).Error; err != nil {
		return nil, -1, err
	}

	return results, totalRows, nil
}