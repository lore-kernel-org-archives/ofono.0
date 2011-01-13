Content-Type: multipart/mixed; boundary="===============1013907054973194401=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@intel.com>
Subject: Re: [PATCH 00/21] Resubmit Zhenhua Zhang work on DUN server with btio
Date: Thu, 13 Jan 2011 13:01:16 +0100
Message-ID: <4D2EE98C.9070304@intel.com>
In-Reply-To: <201101131118.44693.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1013907054973194401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 01/13/2011 10:18 AM, R=C3=A9mi Denis-Courmont wrote:

> This seems quite useless work to me.

This patch has been on the list for some time now. Why didn't you =

express your concern before that?

> There are a number of AT commands that are required but really do not bel=
ong
> in oFono...

For sure nobody wants oFono depend on everything in the world. But at =

some point, one component will need to do the final job of handling the =

AT command. Whether it is oFono or something else I personally don't =

bother. Having it inside oFono through the plugin mechanism will avoid =

some additional layer of IPC.

>  But doing that in userspace in oFono is probably the slowest
> and most inefficient approach to the problem.

Nowadays, relaying a gprs connection at 56k doesn't need to be done in a =

kernel module.
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============1013907054973194401==--

