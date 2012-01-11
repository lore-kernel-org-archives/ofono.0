Content-Type: multipart/mixed; boundary="===============4124272955825098441=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: How to tweak sim atom
Date: Wed, 11 Jan 2012 16:12:51 +0100
Message-ID: <4F0DA6F3.8070702@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4124272955825098441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

As the thread concerning SIM tweaking was growing fast, I summarized it =

in a new one.

We want to use existing oFono sim atom with CSIM (CDMA SIM) to support =

PIN management and get the IMSI at first place.
So far we have to distinguish CSIM and (U)SIM in order into the atom to =

use PIN management and get the IMSI, as other operations won't be =

possible as explained below.

1) 1st solution is to precise at sim atom creation the modem type, =

however Denis denied this solution. Modem type is used by external =

application and not by oFono core.

2) 2nd solution is to get sim_type by deduction of modem type into =

Huawei plugin. Then we precise this sim_type during atom creation.

3) Another method would be to implement a new entry point into =

ofono_sim_driver, for instance ->GetSimType().
However this method will require to access to the file system:
         - for GSM, that can be done using AT+CRSM (EFdir) or AT+CUAD.
         - for CDMA, we don't have any AT commands to do it.

To complete this solution, we might need for CSIM file system access =

some specific Qualcomm commands.
But for the moment, we have no information/documentation from =

manufacturer regarding CSIM file system access.
Therefore, we will not be able to populate following properties:
- MobileCountryCode
- MobileNetworkCode
- SubscriberNumbers
- PreferredLanguages
- ServiceNumbers
- CardIdentifier
- FixedDialing
- BarredDialing

4) Having 2 drivers can be a solution to make difference between CSIM =

and (U)SIM:
         - "atmodem/sim.c" drivers
         - "cdmamodem/sim.c" drivers
There can be a lib simutil for PIN management and IMSI retrieval whose =

APIs would be called by "atmodem" and "cdmamodem" drivers to avoid =

duplicated code.

Thus we don't implement all file system access entry points for =

"cdmamodem/sim.c", but we can keep suggested GetSimType() for both =

drivers and return CSIM type for CDMA without asking modem (as we can't).
Later this will help us to precise right file id (which is different =

from (U)SIM) while reading CSIM file system, once we have the procedures =

from manufacturer to do it.

Kind regards,
Guillaume

--===============4124272955825098441==--

