# Using GPO to push certs to domain computers
## Stesps
1. Get certs from \\somehost\somefile\somedir
2. Log into some-domaincontroller
3. edit Defuault domain policy and add the certs in the next stesps.
4. IN the console tree, open Computer Configuration\Policies\WindowsSettings\ Security Settings\Public Key Policies
5. right-click Trusted Root Certification Authorites
6. Click Import
7. On "Welcome to the Certificate Import Wizard" page, click next.
8. ON the file import page, type the path to the appropriate certificate files
- some-domaincontroler\C$\
9. ON the Certificate Store page, click Place all certificates in the following store, click next
10. ON the Completing The Import Wizard page, verify that the info you provided is accurate. Click Finish
