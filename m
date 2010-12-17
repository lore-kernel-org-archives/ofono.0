Content-Type: multipart/mixed; boundary="===============2569473854337545406=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test: add a script for STK conformance tests
Date: Fri, 17 Dec 2010 09:32:00 -0600
Message-ID: <4D0B8270.9020003@gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D40188136EF0453@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2569473854337545406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 12/16/2010 10:04 AM, Lucas, GuillaumeX wrote:
> From: Guillaume Lucas <guillaumex.lucas@intel.com>
> =

> To be able to run STK conformance tests at ofono
> level, we need to have a STK agent registered. The
> test-stk-conformance script provided here do that.
> This script is for conformance so all the data input
> of the agent are displayed to be able to check them.
> The existing test-stk-menu is usable only when there
> is a STK menu provided by the (U)SIM card.
> ---
>  test/test-stk-conformance |  226 +++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 226 insertions(+), 0 deletions(-)
>  create mode 100755 test/test-stk-conformance
> =


I really don't like the amount of code copying going on here.  Have you
considered extending the current test-stk-menu with the ability to run
as the 'default' agent instead?  Maybe via a command line option?

Regards,
-Denis

--===============2569473854337545406==--

