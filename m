Content-Type: multipart/mixed; boundary="===============0526460648397247543=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Patch for voice call history plugin merge
Date: Wed, 02 Jun 2010 13:33:47 -0500
Message-ID: <201006021333.47577.denkenz@gmail.com>
In-Reply-To: <4BF2C58D.6090901@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0526460648397247543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Raji,

> I have implemented voice call history plugin using memory mapped file ,
> this implementation tested on meego images right now as an external
> plugin to ofono. I am submitting the code here so that it  can be merged
>  and will be used as builtin plugin  of ofono  in future.  Please review
>  the patch and let me know your decision and any changes that needs to be
>  done for accepting it.

A few general comments:
- Please submit your patches using git send-email so that they can be =

commented on inline.  This ensures that many other eyes will look at your =

patches.
- Before submitting your patches, make sure to run checkpatch.pl from the =

latest kernel to check for style issues.  Running checkpatch.pl locally giv=
es =

me over 100 errors with your submission.
- You have to give a much better explanation for what exactly you're doing =

with the code.  For instance, why are semaphores used to protect writing of =

the call history file?  Who are you protecting from?  Give an overview of a=
t =

least several sized paragraphs, the more the better.  Assume that nobody ha=
s =

an idea about what you're trying to accomplish and you have to educate them.

Other style issues to watch out for:
+// Global Shared data
+typedef struct _SHARED
+{
+	HistoryFileHeader header;
+	void *dataMap;
+	sem_t mutex;
+	int temp_unread;
+	int temp_tail;
+} SharedData;
+

oFono does not use CamelCase for structures, simply use struct file_header =
{} =

or similar.  We also don't use // style comments.

+static SharedData *shared_data =3D NULL;
+
+

Double empty lines are a big no no, get rid of them.

+static void callhistory_emit_voice_history_changed(int );
+

forward declarations should be avoided, particularly for static functions

+	if (unread > 0){
+		callhistory_emit_voice_history_changed(unread);
+	}

Braces for single-statement if/while/for blocks are not to be used

+         	if (!fill ){
+             		ofono_debug("Error allocating init memory");
+             		return FALSE;
+		}
+        =


These lines contain mixed tab / space indentation.  Only tabs are to be use=
d =

for indentation.

The if statement should be preceded and followed by an empty line.

+	// create semaphore
+	if (init_sem() < 0)
+		return FALSE; =

+

The return statement contains a space@the end.  All maintainers have git =

settings that will complain loudly when we try to apply such patches.  Ther=
e =

are many more occurrences of this and all of them need to be fixed.

Add:

[apply]
        whitespace =3D error

to your gitconfig and make sure your patch applies cleanly before submittin=
g.

+	if (unread > 0)
+		callhistory_emit_voice_history_changed(unread);
+    	=

+}

Empty lines at the end of blocks are not required

For other style issues, if in doubt check existing code, it is quite =

consistent.  In general the code won't be looked at in detail until it =

conforms to the style guide.

Please fixup all these issues and resubmit.

Regards,
-Denis

--===============0526460648397247543==--

