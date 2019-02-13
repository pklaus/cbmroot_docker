
### CbmRoot Dockerfiles

This repository contains Dockerfiles for CbmRoot (+FairRoot, +FairSoft).
First, FairSoft is built, then subsequently FairRoot and, finally, CbmRoot.

The resulting images can be found on the Docker Hub. The image hierarchy is as follows:

[opensuse/leap][] → [pklaus/fairsoft][] → [pklaus/fairroot][] → [pklaus/cbmroot][]

[pklaus/cbmroot]: https://hub.docker.com/r/pklaus/cbmroot/
[pklaus/fairroot]: https://hub.docker.com/r/pklaus/fairroot/
[pklaus/fairsoft]: https://hub.docker.com/r/pklaus/fairsoft/
[opensuse/leap]: https://hub.docker.com/r/opensuse/leap/
