Content-Type: multipart/mixed; boundary="===============8236224124561992927=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] gatchat: make sure to unsubscribe the GAtIO write handler
 on disconnect.
Date: Wed, 24 Nov 2010 00:39:18 +0100
Message-ID: <AANLkTin1FkZ65H2pHhgfJY=RMCTbpKzYHgeOeB0wBXCb@mail.gmail.com>
In-Reply-To: <4CEB87E3.8050708@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8236224124561992927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 23 November 2010 10:22, Denis Kenzior <denkenz@gmail.com> wrote:
> Actually I think the right fix is to remove the write watcher in
> io_shutdown.
>
> I pushed an experimental patch 99107c6c9d0ae42eb96621b0fc34972e418f1755,
> please let me know if this fixes the issue.

Yes, seems to have fixed the issue as well.

Thanks

--===============8236224124561992927==--

