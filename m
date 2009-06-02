Content-Type: multipart/mixed; boundary="===============8820244032232540265=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: add a common removing and unregistering exit function for
 interfaces when manager_free and manager_destroy function is called
Date: Mon, 01 Jun 2009 22:57:39 -0500
Message-ID: <200906012257.39773.denkenz@gmail.com>
In-Reply-To: <61563CE63B4F854986A895DA7AD3C17709D9919BA4@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8820244032232540265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Minjun,

On Monday 01 June 2009 20:18:23 Li, Minjun wrote:
> Hi Folks,
> Because I found that manager_destroy function is lack of some exit functi=
on
> calls comparing to manager_free function, I add a common removing and
> unregistering exit function for interfaces when manager_free and
> manager_destroy function is called.

Please use proper coding style when submitting patches.  This means tabs =

instead of spaces, and proper spacing, e.g. 'if () {'  The functions should=
 be =

named appropriately, 'foo_free' just won't work.

Also, only include patches that are specific to the fix, things like mode c=
hange =

are extraneous.   And include a proper commit message.

>
> Best Regards,
> Minjun

Regards,
-Denis

--===============8820244032232540265==--

