Content-Type: multipart/mixed; boundary="===============4590952516067554525=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: rename of vendor-specific interface?
Date: Tue, 23 Oct 2018 10:02:28 -0500
Message-ID: <279b6753-d2c6-e9db-48d5-abc5f8fc1ade@gmail.com>
In-Reply-To: <CAKSBH7FCNFrDXXH5DiTFe6BfXx5+v7Ax6-XRBe7Bwey=b62n5Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4590952516067554525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/23/2018 03:19 AM, Giacinto Cifelli wrote:
> Dear all,
> =

> is it possible to rename the .cinterion.HardwareMonitor interface to
> .gemalto.HardwareMonitor ?

We have no formal policy about the stability of vendor specific APIs. =

So there's nothing preventing you from changing this.  But it might not =

be nice to simply remove this interface in case someone is actually =

depending on it.  So you might want to consider exposing both versions =

(at least for actual Cinterion modems) for a few releases.

> =

> If not, can I keep the old one answering on DBus 'not implemented' for
> all methods?

That's pointless

> =

> Can I add both?
> =


That is what I would do, with a plan for removing cinterion version in a =

N releases (or 6 months or so) to give people a chance to upgrade.

Regards,
-Denis

--===============4590952516067554525==--

