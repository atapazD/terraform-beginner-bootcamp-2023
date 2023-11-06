//package main: declares the package name.
// The main package is special in Go, its where the execution of the program starts.
package main

import (
	"fmt"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	//"log"
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
//in golang, a title case function will get exported
func Provider() *schema.Provider{
	var p *schema.Provider
	p = &schema.Provider{
		ResourcesMap: map[string]*schema.Resource {

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
				//ValidateFunc: validateUUID,
			},
		},
	}
	//p.ConfigureContextFunc = providerConfigure(p)
	return p

}

// func validateUUID(v interface{}, k string) (ws []string, errors []error) {
// 	log.Print('validateUUID:start')
// 	value :=v.(string)
// 	if _,err = uuid.Parse(value); err != nil {
// 		errors = apend(error, fmt.Errorf("invalid UUID format"))
// 	}
// 	log.Print('validateUUID:end')
// 	}