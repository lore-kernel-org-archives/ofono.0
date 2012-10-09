Content-Type: multipart/mixed; boundary="===============0197383880698521076=="
MIME-Version: 1.0
From: Martin Grimme <martin.grimme@gmail.com>
Subject: Fail to register to default network - maybe a race condition
Date: Tue, 09 Oct 2012 21:30:37 +0200
Message-ID: <CAK4ndc+OKLTnOSStZu4geruaLNj_kujsE0udsBiYpDhpWbcgcQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0197383880698521076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm experiencing a strange behavior with ofono (1.10) and the Huawei
EM770W modem on Pegatron Lucid (WeTab) hardware. The same used to work
well with ofono 1.8.

As soon as I get notified about the availability of
org.ofono.NetworkRegistration, I'm calling
org.ofono.NetworkRegistration.Register on that modem. However, this
shows no effect.
See http://pastebin.com/CAVEvsA2 for a trace of ofonod.

But when using the test-network-registration test script from ofono to
connect to the default network, it works, even though the script also
only uses org.ofono.NetworkRegistration.Register to register.
See http://pastebin.com/9RQbd8QU for a trace of ofonod.

The code I'm using for registration is here:
http://pastebin.com/fkVVVc1a


Regards,
Martin

--===============0197383880698521076==--

