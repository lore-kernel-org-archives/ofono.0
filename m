Content-Type: multipart/mixed; boundary="===============7792185725081298708=="
MIME-Version: 1.0
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Subject: api property notification order
Date: Tue, 03 Jan 2012 11:55:44 +0200
Message-ID: <CAHiDW_HcL72aqnazPCSB8LrepEAbJkm161U77QJTpzKqrhWTNQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7792185725081298708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm wondering if there could be some additional promises made by the
API about the order of certain property changes and method call
returns. I realize what I'm talking about is fairly close to an API
change so it's more like a discussion starter than a ready suggestion.

The exact problem I ran into is that property changes that are a
result of a API method call are notified _after_ the method call
returns. From an API user point of view that is wrong. As an example I
thought this would be a fairly logical way to handle PIN resets:
  * property change SimManager.PinRequired=3D"puk" -> show pin reset UI to =
user
  * user enters PUK and new PIN -> call SimManager.PinReset()
  * wait for method to return, present any errors. In particular
org.ofono.Error.Failed:
    "It looks like you entered the wrong PUK. You can try again X more
times before the SIM is permanently locked"
Doing that will mislead the user really badly as the Retries-property
hasn't been decreased yet...

From my point of view the order of events should be:
 1. properties that are less likely to trigger UI actions themselves
(e.g. "Retries", "ServiceNumbers")
 2. properties that can be expected to trigger UI actions themselves
(e.g. "PinRequired")
 3. method call returns
The distinction between 1 and 2 is sugar coating but unless method
calls return after property changes, UI development will be more
complex than I thought.

Jussi

--===============7792185725081298708==--

