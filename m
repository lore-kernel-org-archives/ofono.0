Content-Type: multipart/mixed; boundary="===============6158916028923469949=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] xmm7modem: enabling simtoolkit for xmm7modem
Date: Fri, 07 Jun 2019 11:15:37 -0500
Message-ID: <eb75c89f-adfe-2365-3775-231d59e23225@gmail.com>
In-Reply-To: <9BCC1739A7EADA4790E1FFF4123FB3268BB1DF1B@BGSMSX101.gar.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6158916028923469949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

No top-posting on this list please.

On 06/07/2019 01:15 AM, Borwankar, Antara wrote:
> Hi Denis,
> =

> xmm needs a sim reset after enabling stk otherwise proactive command for =
set up menu is not received.

So resetting the SIM during .enable is not enough?  Does this happen =

every time (e.g. on a new boot) or only when you shutdown / restart oFono?

Is the new modem firmware behaving somehow differently from the earlier =

ones?  I mean both the ifx (6160/6260) and ril_intel have stk in =

post_sim with no apparent issues.

Really, I suspect that the firmware should not be performing any =

initialization until XSATK=3D1 was sent; or at the very least re-issue the =

last menu notification when XSATK=3D1 is enabled.

> =

> When I put ofono_stk_create in post sim, on performing sim reset the cont=
rol went into infinite loop of pre_sim and post_sim function calls.
> =


I'm not quite sure how you accomplished that.  But in general you =

shouldn't be performing any power cycling or sim resets in the atom =

drivers.  Only the modem driver should do that.

Regards,
-Denis

--===============6158916028923469949==--

