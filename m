Content-Type: multipart/mixed; boundary="===============8578149293931727603=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/1] huawei: reopen modem channel if it disconnects
Date: Tue, 21 Feb 2017 11:14:15 -0600
Message-ID: <08c3fe6e-2a1a-82c5-3e28-7b2978beca0c@gmail.com>
In-Reply-To: <20170221103729.23967-2-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8578149293931727603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 02/21/2017 04:37 AM, Christophe Ronco wrote:
> On E3372 after a GPRS disconnection, modem AT channel (used by PPP) gets
> disconnected (G_IO_HUP and G_IO_ERR are detected in received_data
> in gatio.c).
> After that all connection attempts fail because we are not able to send
> any AT commands on modem channel (it is closed).
>
> With this patch, when this behavior is detected, we close gprs context
> driver, reopen AT channel and gprs context driver.
> ---
>  plugins/huawei.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 50 insertions(+), 7 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============8578149293931727603==--

