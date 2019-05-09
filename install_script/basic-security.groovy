#!groovy

import jenkins.model.*
import hudson.util.*;
import jenkins.install.*;
import hudson.security.*

def instance = Jenkins.getInstance()

instance.setInstallState(InstallState.INITIAL_SETUP_COMPLETED)

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin","jenkins")
instance.setSecurityRealm(hudsonRealm)
instance.save()
