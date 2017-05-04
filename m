Content-Type: multipart/mixed; boundary="===============0678196212817908413=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v6 2/3] doc/handsfree-audio-api: Add Acquire method
Date: Thu, 04 May 2017 11:22:35 +0300
Message-ID: <20170504082236.9977-2-luiz.dentz@gmail.com>
In-Reply-To: <20170504082236.9977-1-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0678196212817908413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Acquire method which can be used by agents that require
pulling the fd directly instead of waiting a NewConnection.

Note: sounds servers like PulseAudio do auto suspend streams when idle
for a certain amount of time and once anything happens it will resume
the stream, though this all happens in the so called IO thread in a
blocking fashion making it impossible to receive the fd via NewConnetion
causing the stream to fail to resume. There are other forms to work
around but this seems to be most convenient as we do want the auto
suspend feature to work properly but letting the stream to fail to
resume may create unexpected artifacts while the NewConnection is
handled in main thread.
---
 doc/handsfree-audio-api.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/handsfree-audio-api.txt b/doc/handsfree-audio-api.txt
index d82035c..87d51cf 100644
--- a/doc/handsfree-audio-api.txt
+++ b/doc/handsfree-audio-api.txt
@@ -76,6 +76,22 @@ Methods		dict GetProperties()
 					 [service].Error.NotImplemented
 					 [service].Error.NotAllowed
 =

+		fd, byte Acquire()
+
+			Attempts to establish the SCO audio connection
+			returning the filedescriptor of the connection and the
+			codec in use.
+
+			Note: Contrary to Connect this does not call
+			NewConnection so it can be called in a blocking
+			manner.
+
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.Failed
+					 [service].Error.NotAvailable
+					 [service].Error.NotImplemented
+					 [service].Error.NotAllowed
+
 Signals		PropertyChanged(string name, variant value)
 =

 			This signal indicates a changed value of the given
-- =

2.9.3


--===============0678196212817908413==--

