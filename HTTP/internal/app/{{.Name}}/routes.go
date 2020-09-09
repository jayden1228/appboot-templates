package {{.Name}}

import (
	"{{.Name}}/internal/app/{{.Name}}/modules/healthz"
	"github.com/gin-gonic/gin"
)

func registerRouters(router *gin.Engine) {
	router.GET("healthz", healthz.HandleHealthz)
}
