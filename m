Content-Type: multipart/mixed; boundary="===============8725655483435501166=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [isimodem-ussd PATCH 0/5] USSD fixes
Date: Thu, 16 Sep 2010 13:54:31 -0500
Message-ID: <4C9267E7.6080801@gmail.com>
In-Reply-To: <1284658369-1988-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8725655483435501166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 09/16/2010 12:32 PM, Pekka.Pessi(a)nokia.com wrote:
> Hi all,
> =

> I've updated the isimodem ussd implementation to allow network-initiated
> operations. I've added some debug logging to the core ussd, too.
> =

> The isimodem ussd now works with simple USSD applications with
> puSS-Request and uSS-Requests, but uSS-Notifys while a mobile-originated
> puSS-Request is pending seem not to work properly.
> =


All five patches have been pushed.  I did get a small compilation error
(64 bit system).  Please check that the fix is appropriate.

Regards,
-Denis

--===============8725655483435501166==--

