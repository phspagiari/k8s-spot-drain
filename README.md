# k8s-spot-drain
Monitors spot termination signal and gracefully drain the node before termination.

AWS returns the termination time on `http://169.254.169.254/latest/meta-data/spot/termination-time` 2 minutes before the instance terminates.
The idea behind this simple script is to drain gracefully the node before AWS abruptly terminate the instance.

I strongly suggest you to **always** use with a ServiceAccount instead of a token, for sanity's sake.

## How to use / deploy
1. Update the daemonset file with your needs
2. Apply everything: `kubectl apply -f deploy/`


## Considerations
 - You can change the `DEBUG` env to **true** if the *radio silence* of the script is annoying you :)
 - **Don't forget to update the nodeSelector with your spot node label**
