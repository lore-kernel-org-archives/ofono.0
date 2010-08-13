Content-Type: multipart/mixed; boundary="===============2508134586425580856=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH 2/2] huawei: postpone post_sim until SIM is ready
Date: Fri, 13 Aug 2010 11:15:05 +0300
Message-ID: <87eie353p2.fsf@potku.valot.fi>
In-Reply-To: <4C633104.7000502@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2508134586425580856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior <denkenz@gmail.com> writes:

> So this problem affects multiple modem families and I think we should
> solve it a bit better.  What I'm proposing is to introduce a new
> function to include/sim.h.  Something like:
>
> void ofono_sim_ready_notify(struct ofono_sim *sim);
>
> The way it should work is as follows:
>
> When oFono determines the SIM PIN is READY, it checks whether
> ofono_sim_ready_notify has been called.  If it hasn't, then it stalls
> the initialization procedure (and calling post_sim) until
> ofono_sim_ready_notify is called.
>
> This way if the SIM is not PIN locked, the driver can call sim_inserted
> and sim_ready at once.  If the PIN is locked, the driver can notify
> sim_ready later.

Sounds good to me. Do you want to implement it? ;) I'm a bit busy right
now and it might take some time before I can find time for this.

-- =

Kalle Valo

--===============2508134586425580856==--

