Content-Type: multipart/mixed; boundary="===============5925627270221481346=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] dundee: disconnect bluetooth link in case dial fails
Date: Fri, 17 Aug 2012 15:01:53 +0200
Message-ID: <20120817130153.GA15009@candlejack.bmw-carit.intra>
In-Reply-To: <1344894726-19836-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5925627270221481346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Mon, Aug 13, 2012 at 06:52:06PM -0300, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> =

> If the ATD*99# dial fails for some reason, NO CARRIER, for example, we
> need to disconnect the bluetooth link and do further clean up on
> disconnect_callback().

Patch applied.

thanks,
daniel

--===============5925627270221481346==--

