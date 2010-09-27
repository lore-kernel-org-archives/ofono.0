Content-Type: multipart/mixed; boundary="===============5986951953038517161=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: SMS agent interface
Date: Mon, 27 Sep 2010 19:54:12 +0300
Message-ID: <1285606459-1297-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5986951953038517161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

This following set of patches introduces an agent interface for
receiving text messages as well as vCard and vCal objects. It grows a
pair of methods on the org.ofono.MessageManager interface for
registering and unregistering such agents.

I've included the patches introducing datagram support to history that
I sent out separately earlier today. I think these should be evaluated
as a bunch, plus, they introduced some refactoring to the sms atom's
dispatch logic that I didn't feel like redoing. ;)

Basically, all text(ish) messages can now be received via the agent
interface on the sms atom, and then further support for dispatching
handlers based on other dst/src port numbers would happen via the
history API.

An example of such a plugin would be a WAP push handler that would
handle the WAP push datagrams exposing an appropriate D-Bus interface
for applications to process them further.

What is still missing is sending support for vCard and vCalendar,
which for consistency should probably be implemented as a pair of
methods on the org.ofono.MessageManager interface.

Cheers,
Aki

--

 Makefile.am         |    2 +-
 doc/message-api.txt |   51 ++++++++
 include/dbus.h      |    1 +
 include/history.h   |    5 +
 src/history.c       |   47 +++++++-
 src/ofono.h         |    8 ++
 src/sms.c           |  187 +++++++++++++++++++++++++---
 src/smsagent.c      |  344 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/smsagent.h      |   56 +++++++++
 test/sms-agent      |   59 +++++++++
 10 files changed, 741 insertions(+), 19 deletions(-)


--===============5986951953038517161==--

