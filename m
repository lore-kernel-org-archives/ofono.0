Content-Type: multipart/mixed; boundary="===============7561723681892402303=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] telit: stay 'online' until POST_SIM state reached
Date: Tue, 04 Dec 2012 23:55:39 -0600
Message-ID: <50BEE1DB.10905@gmail.com>
In-Reply-To: <1354636010-9624-1-git-send-email-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7561723681892402303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 12/04/2012 09:46 AM, Jonas Bonn wrote:
> In offline state where CFUN=3D4, the Telit HE910 also powers down the SIM
> card so AT commands that query the SIM will fail.  These failures result
> in ofono not getting to POST_SIM state where it will export the GPRS
> feature.

Does the HE910 have a proper CFUN mode where it does not turn off the =

SIM?  You are making some nasty hacks because of it, and the other Telit =

devices support this just fine.

>
> This patch changes the Telit driver so it will not go immediately
> to CFUN=3D4 after enable, but to wait for the post_sim state to be
> reached before doing so.  In addition, the HE910 might send QSS: 0
> unsolicited reports while in CFUN=3D4 state... this patch makes it so
> that these are ignored until the modem is onlined and the actual
> SIM state can be queried again.

Also remember the modem can be 'Online' even without a SIM, or in =

pre-SIM state for e.g. emergency calls.  So much of the logic might break.

Regards,
-Denis

--===============7561723681892402303==--

