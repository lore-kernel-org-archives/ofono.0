Content-Type: multipart/mixed; boundary="===============3215758069751633880=="
MIME-Version: 1.0
From: Bernhard Guillon <Bernhard.Guillon@hale.at>
Subject: Re: [PATCH v2 2/3] network-registration.c: implement CIND
 forTelitUC864-G
Date: Tue, 07 Jun 2011 14:01:21 +0200
Message-ID: <alpine.DEB.2.00.1106071357550.4297@entw48>
In-Reply-To: <4DDB5BD5.7010303@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3215758069751633880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On Tue, 24 May 2011, Denis Kenzior wrote:

> However, I really don't like this patch hardcoding the signal
> index/min/max inside at_creg_set_cb.  Telit is a nicely compliant modem,
> we should be able to trust what it reports.
>
> Bernhard, a question for you: what does the UC864-G return when issuing:
> 'AT+CIND=3D?'

Hi,

AT+CIND=3D?
+CIND: =

(("battchg",(0-5,99)),("signal",(0-7,99)),("service",(0,1)),("sounder",(0,1=
)),("message",(0,1)),("call",(0,1)),("roam",(0,1)),("smsfull",(0,1)),("rssi=
",(0-5,99)))

I reworked the network-registration part and made it more general. Patch =

follows...

Best regards,
Bernahrd


--
Scanned by MailScanner.


--===============3215758069751633880==--

