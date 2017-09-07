Content-Type: multipart/mixed; boundary="===============2629426038846149558=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] autotools: enable maintainer mode by default
Date: Thu, 07 Sep 2017 11:46:04 -0500
Message-ID: <8b211443-bc9c-28df-0583-8fb4f6051046@gmail.com>
In-Reply-To: <20170907121136.13520-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2629426038846149558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 09/07/2017 07:11 AM, Jonas Bonn wrote:
> Disabling "maintainer mode" is not particularly useful as it really only
> saves people who accidentally touch a build system file in an
> unrealistically constrained system where the build tools are uninstalled
> and unavailable.
> =

> This patch just changes the default to 'enabled' so that the changes to
> build system files have the desired effect.
> =

> Passing --disable-maintainer-mode to ./configure restores the previous
> behaviour for the (likely non-existant) users who actually require to do
> so.

If you're building from git, just use bootstrap-configure.  Otherwise =

maintainer mode is there for a reason (e.g. it builds a bunch of tools =

not useful in release builds).  So NAK.

Regards,
-Denis

--===============2629426038846149558==--

