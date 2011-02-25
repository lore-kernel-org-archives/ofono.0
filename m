Content-Type: multipart/mixed; boundary="===============4138461190717112745=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] stk: Add null pointer check
Date: Fri, 25 Feb 2011 13:39:22 +0100
Message-ID: <AANLkTin=rBFxJ-EbUOKs71nKspQmf6qVXBcCWfCyo8G=@mail.gmail.com>
In-Reply-To: <1298630359-4774-1-git-send-email-lasse.kunnasluoto@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4138461190717112745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lasse,

On 25 February 2011 11:39, Lasse Kunnasluoto
<lasse.kunnasluoto@tieto.com> wrote:
> Fixes a crash when SIM Session End is received while waiting for user res=
ponse to SELECT ITEM command.

Can you post the ofono debug log for example?  It sounds like
something else is wrong because stk_respond should not be called when
the session is ended by the card.

Best regards

--===============4138461190717112745==--

