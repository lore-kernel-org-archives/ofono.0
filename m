Content-Type: multipart/mixed; boundary="===============6345799500049107965=="
MIME-Version: 1.0
From: Li, Minjun <minjun.li@intel.com>
Subject: RE: add a common removing and unregistering exit function for
 interfaces when manager_free and manager_destroy function is called
Date: Wed, 03 Jun 2009 11:08:30 +0800
Message-ID: <61563CE63B4F854986A895DA7AD3C17709D9919FC1@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <9F0C1DB20AFA954FA1DA05309350433D7AE7FE33@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6345799500049107965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,
Thanks for your kind help!

Best Regards,

Minjun
-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Xu, Martin
Sent: 2009=E5=B9=B46=E6=9C=883=E6=97=A5 10:25
To: ofono(a)ofono.org
Subject: RE: add a common removing and unregistering exit function for inte=
rfaces when manager_free and manager_destroy function is called

Hi Mingjun:
Since it uses the kernel coding style, you can use checkpatch.pl from kerne=
l to check your patch before you submit it. :)
I have attached the script in my attachment in case you are not familiar wi=
th kernel. =


-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Denis Kenzior
Sent: 2009=E5=B9=B46=E6=9C=882=E6=97=A5 11:58
To: ofono(a)ofono.org
Subject: Re: add a common removing and unregistering exit function for inte=
rfaces when manager_free and manager_destroy function is called

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
_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono

--===============6345799500049107965==--

