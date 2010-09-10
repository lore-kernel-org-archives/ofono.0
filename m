Content-Type: multipart/mixed; boundary="===============6805581494838972899=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [originated PATCH 0/2]
Date: Fri, 10 Sep 2010 13:59:09 +0300
Message-ID: <AANLkTin9PpRrd1GHefXJLUA1WtKZ-HVpqxyjkAKqsa8X@mail.gmail.com>
In-Reply-To: <4C8843E6.5060106@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6805581494838972899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> This patch adds the "Originated" property to the VoiceCall interface. It
>> is used to determine if the call is originated from the mobile or not.
>
> Just throwing ideas, but would 'string Direction' with possible values
> "in" or "incoming" and "out" or "outgoing" be a bit clearer?

It sounds better, yes.

>> The originated information can be deducted from the call state assuming
>> the client does follow the call states from the beqginning. However,
>> after the call gets activated call states are common for the mobile
>> originated and mobile terminated calls.
>
> Out of curiosity, how exactly is this useful?

For logging purposes. Recovering after a call-related server.

There might be some weird calls with no intermediate calls where there
are no intermediate states, too. SRVCC comes to mind, there the cs
call gets created out of thin air.

-- =

Pekka.Pessi mail at nokia.com

--===============6805581494838972899==--

