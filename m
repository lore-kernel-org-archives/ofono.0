Content-Type: multipart/mixed; boundary="===============6410128926152812801=="
MIME-Version: 1.0
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Subject: trying to understand context creation
Date: Tue, 21 Feb 2012 17:20:58 +0200
Message-ID: <CAHiDW_GHn=WQeKbS8w2H_XrFCbGyMid1-=PazuUVx-M=nt+6TA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6410128926152812801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
I'm looking at how I'm creating and using internet contexts to make
sure I'm not missing any problem cases, and I feel like I don't have
much feedback on what is happening and what possibly scenarios I
should be ready for. Dennis explained the ConnectionManager "life
time" last week which helped a lot (thanks) but I'm still struggling.

I've listed some steps that may happen from user/GUI point of view and
the questions I have (some are connman related but I think this is
still the better list):

* Modem with ConnectionManager appears
A ConnectionContext may have been created automatically or not. Under
what  circumstances does this happen? E.g. If the mobile broadband db
contains several plans for a MNC/MCC does ofono try them until one
works or is the selection left to user? Are there checks to make sure
the created context is valid for the network?

* If a ConnectionContext does not appear, UI/user may create one.
using ConnectionManager.AddContext() and
ConnectionContext.SetProperty().
Are there checks at this point to ensure that the created context is
valid and should work? If not, is there anythign I can do to check
context validity?

* Connman exposes a cellular service
What are the conditions for this to happen? If connman exposes a
service, should that "Just work" (with normal caveats about internet
connections) or does it appear for any context that has been created?

* Finally, user can connect the cellular service exposed by connman
If the connection with a cellular service fails, is there anything
else than "Error=3Dconnect-failed" to work with? What are the potential
reasons for this -- is it just the normal issues with any network
connection, or can e.g. broken APN settings be a reason for failure at
this point?


In case background helps to understand it, this uncertainty came to be
from two issues (possibly related ones):
1. a tester is telling me nothing happens when he selects his plan
using dawati networks panel (ofono is 1.0 so automatic context
creation does not work), in other words the service isn't appearing in
connman. Now, I know how to start digging to the specific  problem in
this case, but I'd like to make sure I'm handling all the relevant
error cases... What are the possible points of failure in this? Is it
just the method calls in ConnectionManager and ConnectionContext plus
Connman Service.Error after trying to connect to the service?
2. I've been testing ofono 1.4 and it seems I can succesfully create a
context with any values of APN/username/password and a connman service
will appear. Is this supposed to happen? (Calling Connect() on this
service will timeout and in the end set "Error=3Dconnect-failed", which
is to be expected)


- Jussi

--===============6410128926152812801==--

