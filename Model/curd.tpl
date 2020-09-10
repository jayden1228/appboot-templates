package {{.PackageName}}
import (
	gdb "gitlab.com/makeblock-go/mysql"

	"github.com/jinzhu/copier"
)

{{.TableComment}}
type {{.StructName}} struct {
{{range $j, $item := .Fields}}{{$item.Name}}       {{$item.Type}}    {{$item.FormatFields}}        {{$item.Remark}}
{{end}}
}

// Table is function set the ORM database name
func (e *{{.StructName}})TableName() string {
	return "{{.TableName}}"
}

// Add is a function to add a single record to {{.TableName}} table
// error - ErrInsertFailed, db save call failed
func (e *{{.StructName}})Add() (result *{{.StructName}}, err error) {
    db := gdb.GetDB().Create(e)
	if err = db.Error; err != nil {
	    return nil, ErrInsertFailed
	}
	return e, nil
}

// Delete is a function to delete a single record from {{.TableName}} table
// error - ErrDeleteFailed, db Delete failed error
func (e *{{.StructName}})Delete() (rowsAffected int64, err error) {
    db := gdb.GetDB().Delete(e)
    if err = db.Error; err != nil {
        return -1, ErrDeleteFailed
    }

   return db.RowsAffected, nil
}

// Update is a function to update a single record from {{.TableName}} table
// error - ErrUpdateFailed db.Update call failed
func (e *{{.StructName}})Update() (RowsAffected int64, err error) {
   db := gdb.GetDB().Model(&{{.StructName}}{}).Update(e)
   if err = db.Error; err != nil  {
      return -1, ErrUpdateFailed
   }

   return db.RowsAffected, nil
}

// GetOne is a function to get a single record from the {{.TableName}} table
// error - ErrNotFound, db Find error
func (e *{{.StructName}})GetOne({{range $item := .Fields}} {{ if $item.PrimaryKey }} {{$item.Name}} {{$item.Type}}{{end}}{{end -}}) (record *{{.StructName}}, err error) {
	record = &{{.StructName}}{}
	if err = gdb.GetDB().First(record, {{range $item := .Fields}} {{ if $item.PrimaryKey }} {{$item.Name}},{{end}}{{end -}}).Error; err != nil {
	    err = ErrNotFound
		return record, err
	}

	return record, nil
}

// GetList is a function to get a slice of record(s) from {{.TableName}} table
// params - page     - page requested (defaults to 0)
// params - pagesize - number of records in a page  (defaults to 20)
// params - order    - db sort order column
// error - ErrNotFound, db Find error
func (e *{{.StructName}})GetList(page, pagesize int64, order string) (results []*{{.StructName}}, totalRows int, err error) {

	resultOrm := gdb.GetDB().Model(&{{.StructName}}{})
    resultOrm.Count(&totalRows)

	if page > 0 {
		offset := (page - 1) * pagesize
		resultOrm = resultOrm.Offset(offset).Limit(pagesize)
	} else {
		resultOrm = resultOrm.Limit(pagesize)
    }

	if order != "" {
		resultOrm = resultOrm.Order(order)
	}

	if err = resultOrm.Find(&results).Error; err != nil {
	    err = ErrNotFound
		return nil, -1, err
	}

	return results, totalRows, nil
}