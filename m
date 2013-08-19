Content-Type: multipart/mixed; boundary="===============7553495088355359422=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: PPP negotiation failing
Date: Mon, 19 Aug 2013 08:13:11 -0500
Message-ID: <521219E7.5040304@gmail.com>
In-Reply-To: <52121A10.70605@dataprom.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7553495088355359422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

On 08/19/2013 08:13 AM, Fabio S. Higa wrote:
> Em 16-08-2013 13:05, Denis Kenzior escreveu:
>> The AT command log is not useful in this case.  You would need to run
>> gatchat/gsmdial with the pppdump option and examine it with wireshark
>> to understand what fails.
>>
> Thank you for your help Denis. It seems a problem with PAP/CHAP
> authentication. Just to confirm, does Ofono support PAP authentication?

oFono's PPP stack only supports CHAP.  Patches are of course always welcome.

Regards,
-Denis


--===============7553495088355359422==--

