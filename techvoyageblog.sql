CREATE DATABASE  IF NOT EXISTS `techvoyageblog` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `techvoyageblog`;
-- MySQL dump 10.13  Distrib 8.0.24, for Win64 (x86_64)
--
-- Host: localhost    Database: techvoyageblog
-- ------------------------------------------------------
-- Server version	8.0.24

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(200) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(25) NOT NULL,
  `profile` varchar(255) DEFAULT 'default.png',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'ADMIN','vishalnarsinh@gmail.com','Vishal@123','default.png');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `cid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` varchar(1000) NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Java Programming','Java is very powerful programming language used for web development,app development and software development'),(2,'Tech News and Industry Updates','Tech News and Industry Updates provide timely and relevant information about the latest developments, trends, and innovations in the ever-evolving world of technology. Stay informed about groundbreaking advancements, company announcements, and industry shifts that shape our digital future.'),(3,'Web Technology','Web technology encompasses a wide range of topics and technologies related to the World Wide Web and its development,'),(4,'Mobile App Development','Mobile app development is the process of creating software applications specifically designed to run on mobile devices such as smartphones and tablets. It involves a series of steps, from conceptualizing an app idea to designing, developing, testing, and finally releasing the app to the intended platform, whether it\'s the Apple App Store for iOS devices or the Google Play Store for Android devices.'),(5,'APIs and Libraries','APIs and libraries are essential tools in software development. APIs (Application Programming Interfaces) provide a way for different software components or systems to communicate and interact with each other. Libraries, on the other hand, are collections of pre-written code that developers can reuse to perform common tasks or functions in their applications. Together, APIs and libraries streamline development, saving time and effort, and enabling the creation of more feature-rich and efficient software.'),(6,'AI and Machine Learning','AI (Artificial Intelligence) and Machine Learning are cutting-edge technologies that enable computers and systems to learn from data and perform tasks that typically require human intelligence. AI encompasses a broad range of techniques and approaches, while Machine Learning is a subset of AI that focuses on training algorithms to improve their performance over time. These technologies are revolutionizing industries by automating processes, making predictions, and solving complex problems at unprecedented levels of efficiency and accuracy.'),(7,'Data Science and Analytics','Data Science and Analytics involve the art of extracting meaningful insights and knowledge from data. Explore the world of data-driven decision-making, predictive modeling, and advanced analytics. Uncover patterns, trends, and valuable information that empower organizations to make informed choices and drive success.'),(8,'Cloud computing','Cloud computing is a transformative technology that has revolutionized the way businesses and individuals access, store, and manage data and applications. It involves the delivery of computing services, including servers, storage, databases, networking, software, analytics, and intelligence, over the internet (the \"cloud\") to offer faster innovation, flexible resources, and economies of scale.'),(9,'Python Programming','Python programming is very powerful language and it is used for web development and AI/ML'),(15,'Asp','Asp is framework used for development of Web Applications\r\nIt uses C# , J# or Vb script as backend');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `com_id` int NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `pid` int NOT NULL,
  `uid` int NOT NULL,
  PRIMARY KEY (`com_id`),
  KEY `fk_pid2_idx` (`pid`),
  KEY `fk_uid2_idx` (`uid`),
  CONSTRAINT `fk_pid2` FOREIGN KEY (`pid`) REFERENCES `posts` (`pId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_uid2` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,'Informative ?',4,2),(9,'thanks for the help',11,1),(11,'I Love the fact that there is pre-difened methods in these Wrapper class\nwhich helps alot',4,1);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `lid` int NOT NULL AUTO_INCREMENT,
  `pid` int DEFAULT NULL,
  `uid` int DEFAULT NULL,
  PRIMARY KEY (`lid`),
  KEY `fk_uid_idx` (`uid`),
  KEY `fk_pid_idx` (`pid`),
  CONSTRAINT `fk_pid` FOREIGN KEY (`pid`) REFERENCES `posts` (`pId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_uid1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=279 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (4,1,1),(261,2,1),(270,11,1),(271,5,1),(278,4,1);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `subject` varchar(200) DEFAULT NULL,
  `content` longtext NOT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (3,'vishalnarsinh9@gmail.com','Feedback on Platform Improvement','Hello! I\'ve been using your platform for a while, and I have some suggestions for improvements that could enhance the user experience. Can we discuss how to make it even better?','2023-10-11 05:50:32'),(4,'vishalnarsinh9@gmail.com','Business Inquiry','I represent a business interested in partnering with your platform. Can we discuss potential collaboration opportunities and how it could benefit both parties?','2023-10-11 05:51:33'),(5,'vishalnarsinh9@gmail.com','Concerns about Content or Users','I\'ve noticed some inappropriate content or behavior from certain users on your platform. Is there a way to report these issues and help maintain a safe environment?','2023-10-11 05:52:44'),(6,'mrtaha573@gmail.com','General Inquiry or Partnership Proposal','Hi, I have a few questions about your platform and how it works. Additionally, I\'d like to propose a potential partnership that could be mutually beneficial.','2023-10-14 06:38:32');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `pId` int NOT NULL AUTO_INCREMENT,
  `pTitle` varchar(200) NOT NULL,
  `pContent` longtext NOT NULL,
  `pCode` longtext,
  `pImage` varchar(255) DEFAULT NULL,
  `pDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `pLastEdited` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `pExternalLink` varchar(500) DEFAULT NULL,
  `catId` int NOT NULL,
  `userId` int NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  PRIMARY KEY (`pId`),
  KEY `fk_cid_idx` (`catId`),
  KEY `fk_uid_idx` (`userId`),
  CONSTRAINT `fk_cid` FOREIGN KEY (`catId`) REFERENCES `categories` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_uid` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,' Navigating the World of Java EE: A Comprehensive Guide','Introduction\r<br>\r<br>Java EE, short for Java Platform, Enterprise Edition, is a powerful and robust platform for building enterprise-level applications. Developed by Sun Microsystems (now owned by Oracle Corporation), Java EE has been the go-to choice for developing scalable, secure, and high-performance server-side applications. In this blog, we\'ll delve into what Java EE is, its key components, and why it\'s essential for enterprise application development.\r<br>\r<br>What is Java EE?\r<br>\r<br>Java EE is a set of specifications that extend the Java SE (Standard Edition) platform to provide a comprehensive framework for developing enterprise-level applications. Unlike Java SE, which is mainly used for desktop and standalone applications, Java EE is tailored for building scalable, distributed, and multi-tiered applications that can handle heavy workloads.\r<br>\r<br>Key Components of Java EE\r<br>\r<br>Servlets: Servlets are Java classes that provide a platform-independent way to build web applications. They handle HTTP requests and responses and are the foundation of Java web development.\r<br>\r<br>JSP (JavaServer Pages): JSP is a technology used for creating dynamic web content. It allows Java code to be embedded within HTML, enabling the creation of dynamic web pages.\r<br>\r<br>Enterprise JavaBeans (EJB): EJB is a component-based architecture that simplifies the development of distributed, transactional, and scalable enterprise applications. EJBs come in three flavors: session beans, entity beans, and message-driven beans.\r<br>\r<br>JPA (Java Persistence API): JPA is a specification for managing relational data in Java applications. It provides an object-relational mapping (ORM) framework, making it easier to work with databases.\r<br>\r<br>JMS (Java Message Service): JMS is a messaging standard that allows Java applications to communicate asynchronously. It is essential for building robust and scalable messaging systems.\r<br>\r<br>JCA (Java Connector Architecture): JCA provides a standard way to connect Java EE applications to enterprise information systems (EIS) such as databases, messaging systems, and legacy applications.\r<br>\r<br>JTA (Java Transaction API): JTA is a specification for managing distributed transactions in Java applications. It ensures data consistency and reliability across multiple resources.\r<br>\r<br>JMX (Java Management Extensions): JMX is a technology for monitoring and managing Java applications, making it easier to maintain and troubleshoot enterprise systems.\r<br>\r<br>Java EE Security: Java EE includes a comprehensive security model that allows developers to implement authentication, authorization, and data encryption in their applications.\r<br>\r<br>Why Choose Java EE for Enterprise Development?\r<br>\r<br>Portability: Java EE applications are platform-independent, which means they can run on any Java EE-compliant application server, providing flexibility and reducing vendor lock-in.\r<br>\r<br>Scalability: Java EE\'s architecture is designed for scalability, allowing applications to handle increased loads by adding more hardware resources or by clustering.\r<br>\r<br>Reliability: Java EE promotes the development of robust and reliable applications through features like transaction management and failover support.\r<br>\r<br>Security: Java EE provides a robust security framework, making it easier to implement authentication, authorization, and encryption in applications.\r<br>\r<br>Community and Ecosystem: Java EE has a vast and active community, ensuring that developers have access to a wealth of resources, libraries, and tools.\r<br>\r<br>Longevity: Java EE has a proven track record of being a stable and reliable platform, making it a safe choice for long-term projects.\r<br>\r<br>Compliance: Java EE specifications are rigorously tested for compliance, ensuring that applications developed using Java EE adhere to industry standards.\r<br>\r<br>Conclusion\r<br>\r<br>Java EE is a powerful platform for building enterprise-level applications, offering a rich set of specifications and components that simplify the development of scalable, reliable, and secure systems. While Java EE has evolved over the years and has faced competition from other technologies like Spring Framework, it remains a strong choice for enterprise application development, especially when portability, scalability, and robustness are paramount. As you embark on your journey to build enterprise applications, consider Java EE as a solid foundation for your projects.','','java-ee.jpg','2023-09-29 04:16:16','2023-10-15 10:57:36','https://www.oracle.com/java/technologies/java-ee-glance.html',1,1,'active'),(2,'Java EE vs. Jakarta EE: Understanding the Evolution of Enterprise Java','Introduction\r<br>\r<br>Enterprise Java, known for its robustness and scalability, has played a significant role in building complex, mission-critical applications for decades. However, the landscape of enterprise Java has evolved over time. The transition from Java EE (Java Platform, Enterprise Edition) to Jakarta EE represents a pivotal moment in the history of this technology. In this blog, we\'ll explore the differences between Java EE and Jakarta EE and understand why Jakarta EE has become the future of enterprise Java.\r<br>\r<br>Java EE: The Foundation\r<br>\r<br>Java EE, formerly known as J2EE (Java 2 Platform, Enterprise Edition), was developed by Sun Microsystems (now owned by Oracle Corporation) to provide a platform for building scalable, reliable, and secure enterprise applications. Over the years, it has become a popular choice for businesses requiring the development of server-side applications, such as web applications, RESTful services, and enterprise integration solutions.\r<br>\r<br>Key Features of Java EE:\r<br>\r<br>Servlets and JSP: Java EE includes Servlets and JavaServer Pages (JSP) for building dynamic web applications.\r<br>\r<br>Enterprise JavaBeans (EJB): EJB is a component-based architecture for developing scalable and transactional enterprise applications.\r<br>\r<br>JPA (Java Persistence API): JPA simplifies database access and object-relational mapping (ORM) in Java applications.\r<br>\r<br>JMS (Java Message Service): JMS provides messaging capabilities for building distributed and asynchronous applications.\r<br>\r<br>JTA (Java Transaction API): JTA ensures data consistency in distributed transactional systems.\r<br>\r<br>The Transition to Jakarta EE\r<br>\r<br>In 2017, Oracle announced its intention to open-source Java EE, leading to the formation of the Eclipse Enterprise for Java (EE4J) project. Jakarta EE emerged as the new home for cloud-native Java, providing a vendor-neutral, community-driven platform for enterprise Java development.\r<br>\r<br>Key Features of Jakarta EE:\r<br>\r<br>Open Governance: Jakarta EE is now governed by the Eclipse Foundation, allowing for a more open and collaborative development process.\r<br>\r<br>Licensing: Jakarta EE is licensed under the Eclipse Public License (EPL), which offers more flexibility and compatibility for commercial and open-source use.\r<br>\r<br>Modularity: Jakarta EE embraces a modular approach, allowing developers to choose the specific APIs and components they need for their applications.\r<br>\r<br>Cloud-Native Focus: Jakarta EE is designed to meet the challenges of modern cloud-native architectures, including microservices and containerization.\r<br>\r<br>Rapid Development: Jakarta EE aims for a faster release cadence, providing quicker access to new features and improvements.\r<br>\r<br>Choosing the Right Platform\r<br>\r<br>For those familiar with Java EE, transitioning to Jakarta EE should be relatively straightforward, as many of the core technologies remain the same. However, Jakarta EE offers more agility, openness, and adaptability to the changing landscape of enterprise computing.\r<br>\r<br>When deciding between Java EE and Jakarta EE, consider the following:\r<br>\r<br>Legacy Projects: If you have existing Java EE applications, they can continue to run on Jakarta EE with minimal modifications.\r<br>\r<br>New Projects: For new projects, Jakarta EE is the more future-proof choice, especially if you\'re planning to embrace microservices, containers, or cloud-native architectures.\r<br>\r<br>Community Support: Jakarta EE has a growing and vibrant community, which can provide valuable support and resources for developers.\r<br>\r<br>Conclusion\r<br>\r<br>Java EE served as a stalwart platform for enterprise Java applications for many years. However, the transition to Jakarta EE represents an exciting shift towards a more open, modular, and cloud-native future for enterprise Java development. Whether you\'re maintaining existing applications or embarking on new projects, Jakarta EE is poised to be the platform of choice for modern enterprise Java development. Embrace this evolution, and you\'ll be well-prepared for the challenges and opportunities of tomorrow\'s digital landscape.','','Java EE vs Jakarta EE.png','2023-09-29 04:24:19','2023-09-29 04:24:19','',1,1,'active'),(3,'What is Collection Framework','The Collection in Java is a framework that provides an architecture to store and manipulate the group of objects.\r<br>\r<br>Java Collections can achieve all the operations that you perform on a data such as searching, sorting, insertion, manipulation, and deletion.\r<br>\r<br>Java Collection means a single unit of objects. Java Collection framework provides many interfaces (Set, List, Queue, Deque) and classes (ArrayList, Vector, LinkedList, PriorityQueue, HashSet, LinkedHashSet, TreeSet).\r<br>\r<br>What is Collection in Java\r<br>A Collection represents a single unit of objects, i.e., a group.\r<br>\r<br>What is a framework in Java\r<br>-> It provides readymade architecture.\r<br>-> It represents a set of classes and interfaces.\r<br>-> It is optional.\r<br>What is Collection framework\r<br>The Collection framework represents a unified architecture for storing and manipulating a group of objects. It has:\r<br>\r<br>1. Interfaces and its implementations, i.e., classes\r<br>2. Algorithm','// Java program to demonstrate the\r\n// working of ArrayList\r\nimport java.io.*;\r\nimport java.util.*;\r\n\r\nclass GFG {\r\n\r\n	// Main Method\r\n	public static void main(String[] args)\r\n	{\r\n\r\n		// Declaring the ArrayList with\r\n		// initial size n\r\n		ArrayList<Integer> al = new ArrayList<Integer>();\r\n\r\n		// Appending new elements at\r\n		// the end of the list\r\n		for (int i = 1; i <= 5; i++)\r\n			al.add(i);\r\n\r\n		// Printing elements\r\n		System.out.println(al);\r\n\r\n		// Remove element at index 3\r\n		al.remove(3);\r\n\r\n		// Displaying the ArrayList\r\n		// after deletion\r\n		System.out.println(al);\r\n\r\n		// Printing elements one by one\r\n		for (int i = 0; i < al.size(); i++)\r\n			System.out.print(al.get(i) + \" \");\r\n	}\r\n}\r\n','Collection.png','2023-09-29 04:39:47','2023-09-29 04:39:47','',1,1,'active'),(4,'Exploring Java Wrapper Classes:','Introduction<br><br>In the world of programming, both Java and other languages provide us with the tools to work with data. However, Java, being a statically typed language, distinguishes between primitive data types and objects. To bridge this gap and enable the use of primitive types in an object-oriented context, Java introduced the concept of \"wrapper classes.\" In this blog post, we\'ll delve into the world of Java wrapper classes, understanding their purpose, usage, and benefits.<br><br>Understanding Primitive Types<br><br>Before we dive into wrapper classes, let\'s refresh our understanding of primitive data types in Java. Primitive data types are the fundamental building blocks that represent basic values, such as integers, characters, booleans, and floating-point numbers. They have a fixed size in memory and are not objects in the traditional sense.<br><br>The Eight Primitive Data Types:<br><br>byte<br>short<br>int<br>long<br>float<br>double<br>char<br>boolean<br>The Need for Wrapper Classes<br><br>While primitive types are efficient in terms of memory and performance, they lack the features and capabilities of objects. For instance, they cannot be used in collections (like Lists or Sets) or with Java\'s powerful standard library classes. To address this limitation, Java introduced wrapper classes, which are essentially classes that \"wrap\" primitive types, enabling them to be treated as objects.<br><br>The Java Wrapper Classes:<br><br>Byte<br>Short<br>Integer<br>Long<br>Float<br>Double<br>Character<br>Boolean<br>Benefits and Usage of Wrapper Classes<br><br>Object-Oriented Context: Wrapper classes allow primitive types to be used in object-oriented contexts. This is particularly useful when working with libraries and frameworks that expect objects.<br><br>Collections and Generics: Collections in Java, such as ArrayList or HashMap, can only hold objects, not primitive types. Wrapper classes enable the use of primitive types within collections.<br><br>Null Values: Primitive types cannot be assigned a null value. Wrapper classes, being objects, can be assigned null, which can be helpful in various scenarios.<br><br>Utility Methods: Wrapper classes provide useful methods for converting, parsing, and comparing values, which can simplify code and improve readability.<br><br>Autoboxing and Unboxing: Java introduced the concept of autoboxing and unboxing, which automatically convert between primitive types and their corresponding wrapper classes. This makes code more concise and readable.<br><br>Reflection and APIs: Many APIs and libraries utilize objects. Wrapper classes facilitate interaction with these APIs when dealing with primitive values.','import java.util.ArrayList;\nimport java.util.List;\n\npublic class WrapperClassExample {\n    public static void main(String[] args) {\n        // Autoboxing: Primitive to Wrapper\n        Integer intWrapper = 42;  // Autoboxing: int to Integer\n        Double doubleWrapper = 3.14;  // Autoboxing: double to Double\n        Character charWrapper = \'A\';  // Autoboxing: char to Character\n\n        // Working with Collections\n        List<Integer> numbersList = new ArrayList<>();\n        numbersList.add(intWrapper);  // Autoboxing\n        numbersList.add(55);  // Autoboxing: int to Integer\n\n        // Unboxing: Wrapper to Primitive\n        int unwrappedInt = intWrapper;  // Unboxing: Integer to int\n        double unwrappedDouble = doubleWrapper;  // Unboxing: Double to double\n\n        // Parsing String Input\n        String numStr = \"123\";\n        int parsedNum = Integer.parseInt(numStr);\n\n        // Boolean Operations\n        Boolean flag = true;  // Autoboxing: boolean to Boolean\n        if (flag) {\n            System.out.println(\"Flag is true!\");\n        }\n\n        // Comparing Values\n        Integer x = 5;\n        Integer y = 10;\n        int comparisonResult = x.compareTo(y);  // Compare using wrapper class method\n\n        // Displaying Results\n        System.out.println(\"Autoboxing and Unboxing Example:\");\n        System.out.println(\"intWrapper: \" + intWrapper);\n        System.out.println(\"doubleWrapper: \" + doubleWrapper);\n        System.out.println(\"charWrapper: \" + charWrapper);\n        System.out.println(\"numbersList: \" + numbersList);\n        System.out.println(\"unwrappedInt: \" + unwrappedInt);\n        System.out.println(\"unwrappedDouble: \" + unwrappedDouble);\n        System.out.println(\"parsedNum: \" + parsedNum);\n        System.out.println(\"flag: \" + flag);\n        System.out.println(\"Comparison Result: \" + comparisonResult);\n    }\n}\n','Wrapper-Class.png','2023-09-29 04:45:27','2023-10-15 10:57:25','',1,1,'active'),(5,'Exploring Bootstrap 5: The Ultimate CSS Framework','In the fast-paced world of web development, having a reliable and efficient CSS framework can be a game-changer. Bootstrap, with its latest version Bootstrap 5, has been a popular choice for web developers worldwide. In this blog, we\'ll dive deep into Bootstrap 5, exploring its key features, improvements, and why it remains a top choice for building responsive and attractive web applications.\r<br>\r<br>What is Bootstrap?\r<br>Bootstrap is a front-end framework that simplifies web development by providing a collection of pre-built CSS and JavaScript components. Originally created by Twitter developers, Bootstrap has evolved into an open-source project with a thriving community. It\'s designed to help developers create responsive, mobile-first web applications with ease.\r<br>\r<br>Bootstrap 5: The Next Step\r<br>Bootstrap 5 is the latest iteration of this powerful framework, and it brings some exciting new changes and improvements over its predecessor, Bootstrap 4. Let\'s take a closer look at what makes Bootstrap 5 stand out.\r<br>\r<br>1. No More jQuery\r<br>One of the most significant changes in Bootstrap 5 is the removal of jQuery dependency. Instead of relying on jQuery for JavaScript functionality, Bootstrap 5 uses pure JavaScript. This makes your web applications faster, more lightweight, and less prone to conflicts with other JavaScript libraries.\r<br>\r<br>2. Slimmed Down CSS\r<br>Bootstrap 5 has made an effort to reduce its overall file size by eliminating redundant styles and code. This not only improves loading times but also allows for more customization without the burden of excessive CSS bloat.\r<br>\r<br>3. Customizable and Theming\r<br>Customization has always been a key feature of Bootstrap, and Bootstrap 5 takes it a step further. With a more modular architecture, you can easily customize and theme your Bootstrap projects to match your brand or design requirements. The framework\'s new Theming System allows you to define your color schemes, fonts, and more, making it a perfect fit for projects of all types.\r<br>\r<br>4. Improved Grid System\r<br>The grid system in Bootstrap has been enhanced to make it even more flexible and powerful. With new features like vertical alignment, you have finer control over your layout, and the grid system is better equipped to handle complex designs.\r<br>\r<br>5. Responsive by Default\r<br>Bootstrap 5 continues to prioritize mobile-first design. All components and layouts are designed to be responsive out of the box, ensuring that your website looks great on all devices, from large desktop screens to the smallest mobile phones.\r<br>\r<br>6. New Components\r<br>Bootstrap 5 introduces some new components, such as the offcanvas sidebar and accordion component, which provide developers with more tools to create interactive and user-friendly interfaces.\r<br>\r<br>Getting Started with Bootstrap 5\r<br>If you\'re eager to start using Bootstrap 5 in your web projects, follow these steps:\r<br>\r<br>Installation: You can include Bootstrap 5 in your project using various methods, including downloading the source files, linking to a CDN, or using package managers like npm or yarn.\r<br>\r<br>HTML Structure: Begin with the basic HTML structure. Import the Bootstrap CSS and JavaScript files in your HTML document.\r<br>\r<br>Components: Bootstrap 5 offers a wide range of components, including navigation bars, buttons, forms, and more. Explore the documentation to see how to use these components in your project.\r<br>\r<br>Customization: Customize your Bootstrap project to match your brand or design preferences using the Theming System. You can also modify existing components to suit your needs.\r<br>\r<br>Responsive Design: Ensure that your website is responsive by testing it on various devices and screen sizes. Bootstrap\'s responsive classes and utilities make this process easier.\r<br>\r<br>JavaScript: If your project requires interactivity, Bootstrap 5 provides a range of JavaScript plugins and components. Be sure to include the necessary scripts and initialize them correctly.\r<br>\r<br>Conclusion\r<br>Bootstrap 5 continues to be a powerful and versatile CSS framework that simplifies web development. With its improved features, customizability, and mobile-first approach, it remains a top choice for both beginners and experienced developers. Whether you\'re building a small personal website or a large-scale web application, Bootstrap 5 can help you create responsive, attractive, and functional user interfaces. So, give it a try and unlock the potential of this fantastic framework in your web development journey!','','bootstrap-wallpaper.jpg','2023-10-01 12:49:01','2023-10-01 12:49:01','',3,2,'active'),(11,'Exploring the Power and Versatility of Python','\r<br>Introduction\r<br>\r<br>Python is a programming language that has taken the world by storm. Its simplicity, readability, and versatility make it an excellent choice for both beginners and experienced developers. Python has a vast and active community that continually contributes to its growth and adaptability, making it one of the most popular programming languages in the world.\r<br>\r<br>In this blog, we will explore the power and versatility of Python, looking at some of the key reasons why it has gained such widespread popularity and discussing its applications in various fields.\r<br>\r<br>Python\'s Elegant and Readable Syntax\r<br>One of Python\'s most significant advantages is its elegant and readable syntax. The language\'s design emphasizes code clarity, which is achieved through the use of indentation and minimalistic, easily understandable syntax. For newcomers to programming, Python\'s readability can significantly reduce the learning curve and help them grasp essential concepts quickly.\r<br>\r<br>Cross-Platform Compatibility\r<br>Python is a cross-platform language, which means that code written in Python can run on various operating systems without modification. This feature makes Python a practical choice for developing applications that need to work on different platforms seamlessly. It also simplifies the process of sharing and collaborating on code, as there is no need to worry about platform-specific issues.\r<br>\r<br>Extensive Standard Library\r<br>Python includes a vast standard library that covers a wide range of functionalities, making it incredibly powerful for various tasks. Whether you need to work with data, create a web application, or develop a game, Python\'s standard library likely has a module or package to help you get the job done more efficiently. This eliminates the need to reinvent the wheel and speeds up development.\r<br>\r<br>Versatility in Application Development\r<br>Python is not limited to a single domain of application. It excels in various areas:\r<br>\r<br>a. Web Development: Frameworks like Django and Flask have made Python a popular choice for building web applications. Python\'s clean syntax and a variety of libraries simplify web development tasks.\r<br>\r<br>b. Data Science and Machine Learning: Python is widely used in data science and machine learning due to libraries like NumPy, pandas, and scikit-learn. Popular machine learning frameworks, such as TensorFlow and PyTorch, support Python as their primary language.\r<br>\r<br>c. Scientific Computing: Python is a preferred language for scientific research and numerical computing, thanks to libraries like SciPy and Matplotlib.\r<br>\r<br>d. Game Development: Pygame is a popular library for creating 2D games, making Python a great choice for aspiring game developers.\r<br>\r<br>e. Automation and Scripting: Python is widely used for automating repetitive tasks, such as file manipulation, data extraction, and system administration.\r<br>\r<br>Active Community and Ecosystem\r<br>Python has a large and active community of developers and enthusiasts who contribute to its growth. This community-driven approach has resulted in a robust ecosystem of third-party libraries, tools, and frameworks, extending Python\'s capabilities even further. Popular package managers like pip and conda simplify the installation of these libraries and packages.\r<br>\r<br>Conclusion\r<br>\r<br>Python\'s power and versatility have made it a preferred choice for a wide range of applications. Its clean and readable syntax, cross-platform compatibility, extensive standard library, and active community support make it an excellent language for both beginners and experienced developers. Whether you\'re building a web application, diving into data science, or exploring machine learning, Python is a valuable tool that can help you achieve your goals efficiently and effectively. Its continued growth and adaptation to emerging technologies ensure that Python will remain a dominant force in the programming world for years to come.\r<br>','def greet(name):\n    print(f\"Hello, {name}!\")\n\ngreet(\"Alice\")','python.jpg','2023-10-13 09:26:55','2023-10-15 10:57:52','',9,1,'active');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `responses`
--

DROP TABLE IF EXISTS `responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `responses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `subject` varchar(200) DEFAULT NULL,
  `content` longtext,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responses`
--

LOCK TABLES `responses` WRITE;
/*!40000 ALTER TABLE `responses` DISABLE KEYS */;
INSERT INTO `responses` VALUES (1,'vishalnarsinh9@gmail.com','Response for Feedback on Platform Improvement','Thank you for contacting us\nIt would be honour to have your suggestion for improvement of our platform\nBelow is my contact number where we can discuss about your ideas\n98798 79319','2023-10-14 06:33:30'),(2,'mrtaha573@gmail.com','Response for General Inquiry or Partnership Proposal','Thanks for reaching out us\n\nI\'m providing link below for demo of how to use our platform\nhttps://youtu.be/wX9SA-LUeUE?si=IBIltCUZo6s6H9NM\n\nAnd also please let us know about your ideas about partnership with us. We will surely look forward for it.','2023-10-14 06:47:56');
/*!40000 ALTER TABLE `responses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(25) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `about` varchar(500) DEFAULT NULL,
  `registration_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `profile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'default.png',
  `status` enum('active','inactive') DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Vishal Narsinh','vishalnarsinh9@gmail.com','Vishal@123','male','','2023-09-29 02:27:35','lavender-field-1031258.jpg','active'),(2,'Taha Daudi','mrtaha573@gmail.com','Taha@123','male','','2023-09-29 05:52:28','default.png','active');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-20 21:20:15
