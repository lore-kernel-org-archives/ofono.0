Content-Type: multipart/mixed; boundary="===============4416801505318974412=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] huawei: postpone post_sim until SIM is ready
Date: Wed, 11 Aug 2010 18:23:48 -0500
Message-ID: <4C633104.7000502@gmail.com>
In-Reply-To: <20100810095741.18457.64025.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4416801505318974412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

On 08/10/2010 04:57 AM, Kalle Valo wrote:
> On my Huawei E1552 with PIN locked SIM sim_state is 0 when calling
> huawei_post_sim() and gprs context is not registered. This is because
> ^SIMST notification is received only after huawei_post_sim() is called:
> =

> Aug 10 12:38:33 tukki ofonod[6565]: plugins/huawei.c:huawei_post_sim() 0x=
6cdb50
> [...]
> Aug 10 12:38:34 tukki ofonod[6565]: Pcui:< \r\n^SIMST:1\r\n\r\n^SRVST:2\r=
\n
> Aug 10 12:38:34 tukki ofonod[6565]: plugins/huawei.c:notify_sim_state() 1
> =

> Add a test to wait for sim_state to be ready and also a call to
> notify_sim_state() to call huawei_post_sim() whenever needed.

So this problem affects multiple modem families and I think we should
solve it a bit better.  What I'm proposing is to introduce a new
function to include/sim.h.  Something like:

void ofono_sim_ready_notify(struct ofono_sim *sim);

The way it should work is as follows:

When oFono determines the SIM PIN is READY, it checks whether
ofono_sim_ready_notify has been called.  If it hasn't, then it stalls
the initialization procedure (and calling post_sim) until
ofono_sim_ready_notify is called.

This way if the SIM is not PIN locked, the driver can call sim_inserted
and sim_ready at once.  If the PIN is locked, the driver can notify
sim_ready later.

Regards,
-Denis

--===============4416801505318974412==--

