package healthz

import (
	"{{.Name}}/configs"
	"net/http"

	"github.com/gin-gonic/gin"
)

// HandleHealthz healthz handler
func HandleHealthz(c *gin.Context) {
	c.String(http.StatusOK, "Hello,It works. "+configs.Env.APIVersion)
}
