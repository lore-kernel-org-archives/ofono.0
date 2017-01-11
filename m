Content-Type: multipart/mixed; boundary="===============6589192233795729249=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] qmimodem: get password state from modem
Date: Wed, 11 Jan 2017 10:00:10 -0600
Message-ID: <04b5ad4f-b699-139f-ebb0-5a7365113eba@gmail.com>
In-Reply-To: <20170111100648.25936-2-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6589192233795729249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 01/11/2017 04:06 AM, Christophe Ronco wrote:
> Password state and number of retries asked to modem using
> QMI_UIM_GET_CARD_STATUS command rather than remembered after initial
> QMI_UIM_GET_CARD_STATUS command.
> ---
>  drivers/qmimodem/sim.c | 178 +++++++++++++++++++++++++++++++++----------=
------
>  1 file changed, 119 insertions(+), 59 deletions(-)
>

Applied, thanks.  I also went ahead and applied patch #2 from your =

previous series: "qmimodem: add pin_send feature".  Patch #3 no longer =

applies, so please resubmit that one.

Regards,
-Denis


--===============6589192233795729249==--

