# Agave MailDev Server

MailDev is a simple way to test your project's generated emails during development with an easy to use web interface that runs on your machine built on top of Node.js.

This image builds upon the  [https://github.com/djfarrelly/MailDev](https://github.com/djfarrelly/MailDev) project.

## Install & Run

```
docker run -p 1080:80 -p 1025:25 agaveplatform/maildev:latest
```
        
## Using this image

To use this with the Agave Platform Kubernetes stack update your tenant-config, tenant-secret, core-config, and core-secret manifests to send email to the ClusterIP service, `maildev:25`, then deploy the manifest files in the `deployment` folder.

```
kubectl -n sandbox apply -f deployment/
```
 
If you would like to automatically relay emails to their intended destination, update the `maildev-secret.yaml` manifest with your existing SMTP host, username, and password. This will allow you to preview all emails sent through the plaform without interfearing with the normal delivery of notifications. 
  
To access the web ui from outside the cluter, foward port 80 to your localhost using kubectl. 

```
kubectl -n sandbox port-forward service/maildev 10080:80  
```
The web ui will be available at https://localhost:10080/ for convenient access.


## Usage

All the existing maildev options are supported as capitalized, camel case environment variables. (ex. INCOMING_USER, INCOMING_PASS, etc.). The original maildev option are listed below for reference.
 
    maildev [options]

      -h, --help                      output usage information
      -V, --version                   output the version number
      -s, --smtp <port>               SMTP port to catch emails [1025]
      -w, --web <port>                Port to run the Web GUI [1080]
      --ip <ip address>               IP Address to bind SMTP service to
      --outgoing-host <host>          SMTP host for outgoing emails
      --outgoing-port <port>          SMTP port for outgoing emails
      --outgoing-user <user>          SMTP user for outgoing emails
      --outgoing-pass <password>      SMTP password for outgoing emails
      --outgoing-secure               Use SMTP SSL for outgoing emails
      --auto-relay [email]            Use auto-relay mode. Optional relay email address
      --auto-relay-rules <file>       Filter rules for auto relay mode
      --incoming-user <user>          SMTP user for incoming emails
      --incoming-pass <pass>          SMTP password for incoming emails
      --web-ip <ip address>           IP Address to bind HTTP service to, defaults to --ip
      --web-user <user>               HTTP user for GUI
      --web-pass <password>           HTTP password for GUI
      --base-pathname <path>          base path for URLs
      --disable-web                   Disable the use of the web interface. Useful for unit testing
      --hide-extensions <extensions>  Comma separated list of SMTP extensions to NOT advertise
                                      (STARTTLS, SMTPUTF8, PIPELINING, 8BITMIME)
      -o, --open                      Open the Web GUI after startup
      -v, --verbose
      --silent

