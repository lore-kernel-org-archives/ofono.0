Content-Type: multipart/mixed; boundary="===============0828584301304579350=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: Re: [PATCH 2/3] Drop checking whether +CMER is supported.
Date: Tue, 18 Dec 2012 11:08:14 +0100
Message-ID: <50D0408E.40100@hale.at>
In-Reply-To: <1355761338-9081-3-git-send-email-mingli@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0828584301304579350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 17/12/12 17:22, Mingli Wu wrote:
> For Telit HE910,  ofono always got "\r\n+CME ERROR: 14\r\n"
> after issuing "AT+CMER=3D3,0,0,2\r" command. "CME ERROR: 14"
> means that SIM is busy. Now we igonre the result of the
> command "AT+CMER=3D3,0,0,2\r", and register network anyway.
> ---

I submitted some patches which will solve this problem.
You should not get CME ERROR: 14 anymore and hence
the netreg atom will not be removed.
There is not need to make changes in the network registration atom.
Telit supports +CMER but without waiting for the modem to be ready
the command will fail.

Regards,
Christopher

--
Scanned by MailScanner.


--===============0828584301304579350==--

