Content-Type: multipart/mixed; boundary="===============7644068642289951307=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/5] Add Bluetooth HFP memory index dialing V3
Date: Tue, 13 Feb 2018 13:10:39 -0600
Message-ID: <d302c14a-f30d-ed0d-1871-ed8d8ff6842e@gmail.com>
In-Reply-To: <20180212183718.17194-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7644068642289951307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 02/12/2018 12:37 PM, philippedeswert(a)gmail.com wrote:
> From: Philippe De Swert <philippedeswert@gmail.com>
> =

> Hi,
> =

> Finally got some time to redo the patches from last time after all the co=
mments.
> So I renamed the functions to reflect clearly what they are for and avoid=
 functionality
> duplication, used an unsigned int as suggested for the memory index, ditc=
hed callerid/CLIR
> (as it is not supported for bluetooth/hfp) and avoided mixing in differen=
t files in one
> patch as in the coding guidelines.
> =

> Hopefully third time is the charm ;)
> =

> Philippe
> =

> Philippe De Swert (5):
>    voicecall: Rename callbacks/functions related to dialing the last
>      called number
>    voicecall: Add support for dialing number at a given memory location
>    voicecall: Add functionality to manager to dial from a memory
>      location.
>    hfpmodem: Add memory dialling support
>    doc: Document the new DialMemory method of the voicecallmanager-api
> =

>   doc/voicecallmanager-api.txt | 11 ++++++++
>   drivers/hfpmodem/voicecall.c | 25 ++++++++++++++++++
>   include/voicecall.h          |  4 +++
>   src/voicecall.c              | 62 +++++++++++++++++++++++++++++++++++++=
++-----
>   4 files changed, 95 insertions(+), 7 deletions(-)
> =


I went ahead and applied the entire series.  I did fix up a few minor =

style & whitespace issues.

Thanks!

Regards,
-Denis

--===============7644068642289951307==--

