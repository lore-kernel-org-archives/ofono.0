Content-Type: multipart/mixed; boundary="===============1332337291628718911=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH 1/2] dundee: add timeout to close stalled ppp handshake
Date: Fri, 17 Aug 2012 15:02:50 +0200
Message-ID: <20120817130250.GB15009@candlejack.bmw-carit.intra>
In-Reply-To: <1344928472-29531-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1332337291628718911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Tue, Aug 14, 2012 at 04:14:31AM -0300, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> =

> If something goes wrong the PPP handshake can stall, then we just add a
> timer to return an error after a certain timeout (15 seconds).

Both patches applied.

I also updated the documentation on the interface. The SetProperty() was =

missing.

Thanks,
Daniel

--===============1332337291628718911==--

