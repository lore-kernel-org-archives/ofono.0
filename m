Content-Type: multipart/mixed; boundary="===============8801518216781686759=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [SMS D-Bus 02/23] util.h: Add BUILD_BUG_ON() and friends for
 compile-time assert checking
Date: Sat, 26 Jun 2010 01:46:44 +0200
Message-ID: <1277509604.2330.144.camel@localhost.localdomain>
In-Reply-To: <bae960413a408d22e3f6818ae710d051a99a1425.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8801518216781686759==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> These have been stolen from the Linux kernel source; come pretty handy
> to make build-time consistency checks and thus avoid run-time
> surprises.
> ---
>  src/util.h |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)

I still think that using include/bug.h is way better. And that way we
could more easily sync this with ConnMan. Since this might come in handy
for ConnMan as well.

Regards

Marcel



--===============8801518216781686759==--

