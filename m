Content-Type: multipart/mixed; boundary="===============4093870555787807759=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] Check if ussd is busy when doing ss
Date: Mon, 13 Sep 2010 16:18:32 +0300
Message-ID: <AANLkTinwe6A-=zWg0-_D9zRoYw5QdQ6i3198vpToc+e0@mail.gmail.com>
In-Reply-To: <1283739595-11903-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4093870555787807759==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

2010/9/6 Yang Gu <yang.gu@intel.com>:
> It's still not clear how ss and ussd interfere with each other. Current
> decision is each ss (call-barring, call-forwarding, etc.) has
> interference with ussd, but there is no interference within these ss.
> That is, call-barring has interference with ussd, but call-barring has
> no interference with call-forwarding.

There is only one signaling channel for the supplementary services.
Only one supplementary service operation can be active at a time. (Or
two, network can initiate ussd notify or request while
mobile-originated ussd is pending.)

-- =

Pekka.Pessi mail at nokia.com

--===============4093870555787807759==--

