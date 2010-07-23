Content-Type: multipart/mixed; boundary="===============6620901673063181271=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] watch: Free service data in service_reply
Date: Fri, 23 Jul 2010 08:32:34 -0700
Message-ID: <1279899154.2621.20.camel@localhost.localdomain>
In-Reply-To: <1279864871-799-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6620901673063181271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> Avoid the memory leak of server_data.
> ---
>  gdbus/watch.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)

do me a favor and post this to linux-bluetooth(a)vger.kernel.org as well
for the Bluetooth guys to review. After that I can take of applying it
to all trees.

Regards

Marcel



--===============6620901673063181271==--

