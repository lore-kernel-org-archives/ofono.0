Content-Type: multipart/mixed; boundary="===============0969527251148215738=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: use libqmi or .json definition for qmi calls
Date: Mon, 22 May 2017 10:01:03 -0500
Message-ID: <cf9effcc-7c93-8186-6ae1-bcf8682f0e61@gmail.com>
In-Reply-To: <20170522085436.rmpj55rjp22bcvml@nataraja>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0969527251148215738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Harald,

On 05/22/2017 03:54 AM, Harald Welte wrote:
> Hi Denis,
>
> On Tue, May 16, 2017 at 01:33:56PM -0500, Denis Kenzior wrote:
>> libqmi is quite large, depends on weird glib features and is really not =
an
>> option for us.  Furthermore, we will eventually be migrating away from g=
lib,
>> so introducing additional dependencies or libraries that depend on glib =
will
>> just make our life harder in the future.
>
> I can follow that argument.  However, it only applies to libqmi, and not
> to uqmi, which doesn't use glib.  On the other hand, it appears to be
> using libubox, which is very OpenWRT/LEDE specific.

Didn't know uqmi existed.  Looks like that project started about a year =

after qmi driver was functional.  So again, wasn't really a consideration.

But just to make it clear: anything we introduce would have to depend =

only on libc and perhaps on the bare minimum set of features we use from =

glib at the moment.

>
>> When we started our QMI driver, libqmi was still in its early stages. Mu=
ch
>> of the work understanding the protocol still had to be done by hand.  Ba=
ck
>> then we decided that auto-generating the code wasn't worthwhile.  It is
>> almost certain that there will not be multiple QMI based drivers.  So by=
 the
>> time you wrote the JSON definition or equivalent, you could have impleme=
nted
>> the driver method that used it.
>
> This explains the history, sure.
>
> However, it would still be good to get an opinion on what your thoughts
> are to use code generation from the JSON file instead?  The situation
> today is different:  There is a JSON File that appears to have more
> complete QMI coverage than ofono, so it's either "manually writing code

complete, sure.  But then we only use a very small subset of QMI. =

Pointless to generate all this code if you use 5-10% of it.

> to catch up with that file" or "be open towards generation of ofono QMI
> code from that JSON file"
>

Generated code is rarely pretty, or maintainable.  The code generator =

itself can also be quite large.  We played with the idea initially, but =

didn't think the cost-benefit was there.

I have seen auto-generated code used to good effect (e.g. in the Linux =

kernel), but the rules are arcane and bugs easily introduced / =

overlooked.  So I'm open minded, but the devil will be in the details.

> Let's assume somebody would work on generating code from the JSON file
> that had no dependencies to "weird glib features" or glib at all, or a
> library like libubox:
> Would you think it as worth-while to merge such a QMI driver, either as
> separate driver, or even as a replacement to the current one?

I can understand auto-generating qmi data structures and parsers / =

builders, but how are you going to auto-generate the driver?

>
> The amount of interfaces, interface versions and messages on QMI is only
> going to increase over time.
>

You'll have to educate me on that, so far it seems QMI has been frozen =

for 5+ years.

Regards,
-Denis

--===============0969527251148215738==--

