Content-Type: multipart/mixed; boundary="===============0393963487424339350=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: Poll SIM state after entering PIN
Date: Mon, 12 Nov 2012 13:32:10 -0600
Message-ID: <50A14EBA.9090702@gmail.com>
In-Reply-To: <1352467013-1418-1-git-send-email-cedric.jehasse@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0393963487424339350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

On 11/09/2012 07:16 AM, Cedric Jehasse wrote:
> From: Cedric Jehasse<cedric.jehasse@softathome.com>
>
> Encountered a problem of CME ERROR 14: SIM busy on Alcatel and Huawei mod=
em.
> The Huawei modem has a ^SIMST unsollicited sim state indication, but not =
all
> Huawei modems support this.
> So poll the SIM state, as was already done for ZTE modems.
> ---
>   drivers/atmodem/sim.c    |    2 ++
>   drivers/atmodem/vendor.h |    1 +
>   2 files changed, 3 insertions(+), 0 deletions(-)

Patch has been applied, however I broke it up into two commits per our =

Patch Submission Guidelines.  See HACKING.

Regards,
-Denis

--===============0393963487424339350==--

