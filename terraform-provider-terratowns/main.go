//package main: declares the package name.
// The main package is special in Go, its where the execution of the program starts.
package main

import (
	"fmt"
	"context"
	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
	"github.com/google/uuid"
	"log"
)
//import "fmt": imports the fmt package, which contains functions for formatted I/O

//func main(): defines the main function, the entry point of the app
//when running the app it starts executing from this function
func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: Provider,
	})
	//format.print line
	// prints to standard output
    fmt.Println("Hello, World!")
}
type Config struct{
	Endpoint string
	Token string
	UserUuid string
}
//in golang, a title case function will get exported
func Provider() *schema.Provider{
	var p *schema.Provider
	p = &schema.Provider{
		ResourcesMap: map[string]*schema.Resource {
			"terratowns_home": Resource(),
		},
		DataSourcesMap: map[string]*schema.Resource{

		},
		Schema: map[string]*schema.Schema{
			"endpoint" :{
				Type: schema.TypeString,
				Required: true,
				Description: "The endpoint for the external service",
			},
			"token" :{
				Type: schema.TypeString,
				Required: true,
				Description: "The bearer token for authorization",
				Sensitive: true, //make the token sensitive to hide it in the logs
			},
			"user_uuid" :{
				Type: schema.TypeString,
				Required: true,
				Description: "UUID for conffiguration",
				ValidateFunc: validateUUID,
			},
		},
	}
	p.ConfigureContextFunc = providerConfigure(p)
	return p

}

func validateUUID(v interface{}, k string) (ws []string, errors []error) {
	log.Print("validateUUID:start")
	value :=v.(string)
	if _,err := uuid.Parse(value); err != nil {
		errors = append(errors, fmt.Errorf("invalid UUID format"))
	}
	log.Print("validateUUID:end")
	return
	}

func providerConfigure (p *schema.Provider) schema.ConfigureContextFunc {
	return func(ctx context.Context, d *schema.ResourceData) (interface{}, diag.Diagnostics ){
		log.Print("providerConfigure: start")
			config := Config{
				Endpoint: d.Get("endpoint").(string),
				Token: d.Get("toekn").(string),
				UserUuid: d.Get("user_uuid").(string),
			}
		log.Print("providerConfigure:end")
		return &config,nil
	}
}

func Resource () *schema.Resource {
	log.Print("Resource:start")
	resource := &schema.Resource{
		CreateContext: resourceHouseCreate,
		ReadContext: resourceHouseRead,
		UpdateContext: resourceHouseUpdate,
		DeleteContext: resourceHouseDelete,
	}
	log.Print("Resource:start")
	return resource
}

func resourceHouseCreate(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
	var diags diag.Diagnostics
	return diags
}

func resourceHouseRead(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
	var diags diag.Diagnostics
	return diags
}

func resourceHouseUpdate(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
	var diags diag.Diagnostics
	return diags
}

func resourceHouseDelete(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
	var diags diag.Diagnostics
	return diags
}