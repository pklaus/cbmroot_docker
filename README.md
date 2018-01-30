
### CbmRoot Dockerfiles

This repository contains Dockerfiles for CbmRoot (+FairRoot, +FairSoft).
First, FairSoft is built, then subsequently FairRoot and, finally, CbmRoot.

The resulting images can be found on the Docker Hub. The image hierarchy is as follows:

[opensuse:42.3][] → [pklaus/fairsoft][] → [pklaus/fairroot][] → [pklaus/cbmroot][]

[pklaus/cbmroot]: https://hub.docker.com/r/pklaus/cbmroot/
[pklaus/fairroot]: https://hub.docker.com/r/pklaus/fairroot/
[pklaus/fairsoft]: https://hub.docker.com/r/pklaus/fairsoft/
[opensuse:42.3]: https://hub.docker.com/_/opensuse/
