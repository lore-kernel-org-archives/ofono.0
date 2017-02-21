Content-Type: multipart/mixed; boundary="===============0954978089655572374=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/2] Add provisioning plugin from configuration file
Date: Tue, 21 Feb 2017 11:12:32 -0600
Message-ID: <d31d59d2-c420-e880-5877-e0e33ed0a8f8@gmail.com>
In-Reply-To: <20170217144448.23940-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0954978089655572374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 02/17/2017 08:44 AM, Christophe Ronco wrote:
> The goal of this plugin is to provision APN and other internet context de=
tails
> from a configuration file.
>
> The modification from what I sent yesterday:
>  - do not use storage functions anymore
>  - changed section names to be able to add other type of sections in the =
future
>
> Christophe Ronco (2):
>   provision: add plugin to provision from config file
>   plugins: support for provisioning from config file
>
>  Makefile.am              |   4 ++
>  plugins/file-provision.c | 170 +++++++++++++++++++++++++++++++++++++++++=
++++++

Strictly speaking there was no need to separate these into two patches. =

If you're adding a new plugin, then build system changes belong together =

with the code additions.  Just for future reference.

>  2 files changed, 174 insertions(+)
>  create mode 100644 plugins/file-provision.c
>

I squished together patch 1 & 2 into a single commit and applied. Thanks!

Regards,
-Denis

--===============0954978089655572374==--

