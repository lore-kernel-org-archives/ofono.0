Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4BE27281D
	for <ofono@lists.linux.dev>; Mon, 29 Dec 2025 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766996482; cv=none; b=ZCN2axK3Oc3PMZcsap2TP/XfiDJl2wNC34BaC0YXRYNss8rvy3Su5B8TnrOwtBt8C4JIdHYDGQFzbcVpHsmfryiecFwrJMYTHCVE+oEq1VW45S4Ef8ufQMWCVDqjlN/s2fvFjWpOoOh46MFOsV+Ar97KbCK0yYxlLDkiNqGX4TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766996482; c=relaxed/simple;
	bh=3v2SG1T+lDIwLLSAosHY67Y92h51aPUwvG4ylDRVsyk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=OuKBN+rDC3SRhvbTovpouQBAN/a+1LZPN49GPvDBaFH7J3P3d6yDVJ9bHTvP67WsUr4gs9AjtMwx3cicqdlpc8hrci6aXrGv1jzJpnJLAm/785IPR65Desi+b/dQwBcXo8yE6K70SYBemR3CJfSiTpjKFvD0v76lNJYfmm7/Cks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 8A45C110E55; Mon, 29 Dec 2025 03:11:18 -0500 (EST)
Received: from 5400 (unknown [172.56.161.58])
	by spindle.queued.net (Postfix) with ESMTPSA id 3B55E110E2B
	for <ofono@lists.linux.dev>; Mon, 29 Dec 2025 03:11:18 -0500 (EST)
Date: Mon, 29 Dec 2025 03:10:53 -0500
From: Andres Salomon <dilinger@queued.net>
To: ofono@lists.linux.dev
Subject: [PATCH] phonesim: fix exporting of child widgets to javascript
 engine
Message-ID: <20251229031053.1441ddc6@5400>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

Using the example sms.js script in doc/scriptable.txt, the following
error occurs with phonesim built using Qt5.15:

Error org.ofono.phonesim.Error.ScriptExecError: /tmp/sms.js, line 1, TypeError: Cannot read property 'leMessageSender' of undefined

This is due to phonesim creating javascript objects for all the gui
tab widgets, but none of the child widgets inside of those tabs. So
in the javascript engine, 'tabSMS' is available, but its child widget
'gbMessage1' is undefined.

I'm not sure if this is related to behavior changes in current versions
of QJSEngine/UIC or what, but we can manually add all those widgets
to the javascript engine to fix this.
---
 src/control.cpp | 25 +++++++++++++++++++++++++
 src/control.h   |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/src/control.cpp b/src/control.cpp
index 817a0b2..b85e9ad 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -637,32 +637,57 @@ void ControlWidget::modemSilentReset()
     emit unsolicitedCommand("+CRST:");
 }
 
+/*
+ * Recursively add all widgets in a controlbase.ui tab to the javascript
+ * engine so that scripts can reference them. Because the widgets
+ * aren't local to this function, they should remain in scope while the
+ * script executes.
+ */
+void Script::AddChildren(const QWidget *parentW, QJSValue &parentJS)
+{
+    QList<QWidget*> kids = parentW->findChildren<QWidget*>(QString(),
+            Qt::FindDirectChildrenOnly);
+    foreach (QWidget *w, kids) {
+        QJSValue obj = engine.newQObject(w);
+        parentJS.setProperty(w->objectName(), obj);
+        AddChildren(w, obj);
+    }
+}
+
 Script::Script(QObject *obj, Ui_ControlBase *ui) : QDBusAbstractAdaptor(obj)
 {
     /* Export tabs to be accessed by script */
     QJSValue qsTab = engine.newQObject(ui->tab);
     engine.globalObject().setProperty("tabRegistration", qsTab);
+    AddChildren(ui->tab, qsTab);
 
     QJSValue qsTab2 = engine.newQObject(ui->tab_2);
     engine.globalObject().setProperty("tabCBM", qsTab2);
+    AddChildren(ui->tab_2, qsTab2);
 
     QJSValue qsTab3 = engine.newQObject(ui->tab_3);
     engine.globalObject().setProperty("tabSMS", qsTab3);
+    AddChildren(ui->tab_3, qsTab3);
 
     QJSValue qsTab4 = engine.newQObject(ui->tab_4);
     engine.globalObject().setProperty("tabVoiceMail", qsTab4);
+    AddChildren(ui->tab_4, qsTab4);
 
     QJSValue qsTab5 = engine.newQObject(ui->tab_5);
     engine.globalObject().setProperty("tabUSSD", qsTab5);
+    AddChildren(ui->tab_5, qsTab5);
 
     QJSValue qsTab6 = engine.newQObject(ui->tab_6);
     engine.globalObject().setProperty("tabSIM", qsTab6);
+    AddChildren(ui->tab_6, qsTab6);
 
     QJSValue qsTab8 = engine.newQObject(ui->tab_8);
     engine.globalObject().setProperty("tabPosition", qsTab8);
+    AddChildren(ui->tab_8, qsTab8);
 
     QJSValue qsTab9 = engine.newQObject(ui->tab_9);
     engine.globalObject().setProperty("tabCall", qsTab9);
+    AddChildren(ui->tab_9, qsTab9);
 }
 
 void Script::SetPath(const QString &path, const QDBusMessage &msg)
diff --git a/src/control.h b/src/control.h
index be4a366..c160d61 100644
--- a/src/control.h
+++ b/src/control.h
@@ -57,6 +57,8 @@ public slots:
     QString Run(const QString &name, const QDBusMessage &msg);
 
 private:
+    void AddChildren(const QWidget *parentW, QJSValue &parentJS);
+
     QString dirPath;
     QJSEngine engine;
 };
-- 
2.51.0

