Content-Type: multipart/mixed; boundary="===============4361478299370917839=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 0/1] Patch Description
Date: Sat, 25 Sep 2010 11:00:53 +0800
Message-ID: <33AB447FBD802F4E932063B962385B352D6BDDC0@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1285343369-10418-1-git-send-email-gyagp0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4361478299370917839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Yang Gu wrote:
> Phonesim is most of time a convenient way to test oFono. For example,
> it can be used to test MO call, as well as MT call. =

> And talking about test area, test automation is quite important
> regarding to both efficiency and effectiveness. In the test of MO
> call, scripts can be used to interact with oFono via D-Bus to make
> test automation possible. However, in the test of MT call, currently
> we have to enter the caller number and click some button in Phonesim
> GUI to simulate an incoming call, which makes test automation
> unrealistic. This patch is to enable Qt script (JavaScript following
> ECMAScript spec) in Phonesim, so that we can have some script control
> its GUI conveniently, and satisfy the test automation.       =

> =

> With this patch, Phonesim can work in the following way:
> 1. It observes some specific directory (/tmp/scripts) to see if there
> is some test scripts added. =

> 2. Once Phonesim finds a new test script is added, it will parse and
> execute the script. =

> 3. You may add more and more test scripts to the specific directory
> with your test goes on. =

> =

> Below are two examples:
> # call.js (Simulate a MT call)
> tabRegistration.gbIncomingCall.leCaller.text =3D "12345";
> tabRegistration.gbIncomingCall.pbIncomingCall.click();
> =

> This script will help you enter the caller number as "12345", and
> click "Call" button in Phonesim GUI. Once this script is copied to
> the observed directory, oFono will get an incoming call.  =

> =

> # sms.js (Simulate a MT sms)
> tabSMS.gbMessage1.leMessageSender.text =3D "Yang";
> tabSMS.gbMessage1.leSMSClass.text =3D "1";
> tabSMS.gbMessage1.teSMSText.setPlainText("This message is sent
> automatically from Phonesim"); =

> tabSMS.gbMessage1.pbSendSMSMessage.click();
> =

> This script will help you fill the sms sender, class, text, and then
> click the "Send Message" button for you. Once it's added into the
> specific directory, oFono will get an incoming message.  =

> =

> Don't know if this is the best way to make Phonesim support test
> automation. So comments are welcome:) =


It's awesome! I tried the patch and simply copy call.js to /tmp/scripts and=
 it makes a call to oFono like a magic. ;-)

> -----
> Yang Gu (1):
>   Enable Qt Script
> =

>  configure.ac    |    2 +-
>  src/control.cpp |   60
>  +++++++++++++++++++++++++++++++++++++++++++++++++++++++ 2 files
> changed, 61 insertions(+), 1 deletions(-) =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards,
Zhenhua

--===============4361478299370917839==--

