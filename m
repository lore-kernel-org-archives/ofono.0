Content-Type: multipart/mixed; boundary="===============0598038142809450293=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC sim-ready-v1 PATCH 0/3] ofono_sim_ready_notify
Date: Fri, 22 Oct 2010 13:54:19 -0500
Message-ID: <4CC1DDDB.5010903@gmail.com>
In-Reply-To: <1287416435-4307-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0598038142809450293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 10/18/2010 10:40 AM, Pekka.Pessi(a)nokia.com wrote:
> Hi all,
> =

> Here is my 2nd stab at the ofono_sim_ready_notify().
> =

> Main difference from Denis's and Kristen's patch is that the modem
> driver now has a way to indicate that is ready or not: if SIM is not
> ready, the ofono_sim_driver indicates that with query_passwd_state
> callback returning OFONO_SIM_PASSWORD_INVALID. A separate enum and a

I really question the need for this.  The core should simply wait for
ready in both cases.  If the modem driver knows the modem is ready, then
it can simply call ofono_sim_ready_notify after the cpin query callback.
 Reusing OFONO_SIM_PASSWORD_INVALID seems really unclean...

> string value for PinRequired property for that case would probably be
> nice, however, it is not very clear to me how the modems handle the
> transition from PIN-locked SIM to SIM-locked modem.

Having recently peeked at 22.022, it seems pretty clear that all other
personalization types depend on the knowledge of the IMSI.  EFimsi
requires PIN entry, so the modems must all go through the PIN check
first before all other locks.

> =

> After the driver determines that the SIM is ready, it calls
> ofono_sim_ready_notify().
> =


Can you guys try the patch from
http://lists.ofono.org/pipermail/ofono/2010-August/004203.html

Does this one still work as well?

Regards,
-Denis

--===============0598038142809450293==--

