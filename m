Content-Type: multipart/mixed; boundary="===============7703576536766794544=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stk: changes for sim toolkit initialization in rilmodem
Date: Tue, 07 Feb 2017 10:57:31 -0600
Message-ID: <b5d13aec-56b9-5b94-0acd-ce87634d0a8e@gmail.com>
In-Reply-To: <1486448229-17649-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7703576536766794544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 02/07/2017 12:17 AM, ANTARA BORWANKAR wrote:
> sending RIL_REQUEST_REPORT_STK_SERVICE_IS_RUNNING after
> stk atom is created so that modem will inititialize
> sim toolkit by sending terminal profile to sim.
> ---
>  drivers/rilmodem/stk.c | 23 ++++++++++++++++++++++-
>  plugins/ril_intel.c    |  2 ++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>

Applied, thanks.

Regards,
-Denis


--===============7703576536766794544==--

