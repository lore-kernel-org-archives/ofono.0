Content-Type: multipart/mixed; boundary="===============2816585754745705587=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] phonesim: Support for querying SIM unlock retry count.
Date: Tue, 22 Apr 2014 13:14:18 -0500
Message-ID: <5356B17A.6020003@gmail.com>
In-Reply-To: <1398170878-5794-1-git-send-email-jussi.pakkanen@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2816585754745705587==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 04/22/2014 07:47 AM, jussi.pakkanen(a)canonical.com wrote:
> Hi
> =

> Here's a patch for ofono-phonesim. It adds the command AT+CPINR that retu=
rns
> the amount of PIN unlock attempts remaining. It also tracks the value pro=
perly
> according to state changes. The output format is (roughly) as specified i=
n ETSI
> TS 127 007 v11.8.0.
> =

> ---
>  src/default.xml | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> =


Patch has been applied after tweaking the commit subject & description.
 Thanks.

Regards,
-Denis

--===============2816585754745705587==--

