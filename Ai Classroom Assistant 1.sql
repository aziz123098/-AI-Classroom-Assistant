-- ==============================================
-- DROP OLD DATABASE IF EXISTS
-- ==============================================
DROP DATABASE IF EXISTS ai_classroom;
CREATE DATABASE ai_classroom;
USE ai_classroom;

-- ==============================================
-- TABLE: Users (Admin + Teachers + Students)
-- ==============================================
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL, -- hashed password
    role ENUM('admin','teacher','student') NOT NULL,
    student_number VARCHAR(20) DEFAULT NULL, -- for students only
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Insert Admin
INSERT INTO users (full_name, email, password_hash, role) VALUES
('System Admin', 'admin@school.edu.sa', 'hashed_password_here', 'admin');

-- Insert Teachers
INSERT INTO users (full_name, email, password_hash, role) VALUES
('Dr. Faisal Al-Harbi', 'faisal.harbi@school.edu.sa', 'hashed_password_here', 'teacher'),
('Dr. Sami Al-Mutairi', 'sami.mutairi@school.edu.sa', 'hashed_password_here', 'teacher');

-- Insert 10 Students
INSERT INTO users (full_name, email, password_hash, role, student_number) VALUES
('Ahmed Al-Anazi', 'ahmed.anazi@student.edu.sa', 'hashed_password_here', 'student', 'U1001'),
('Omar Al-Qahtani', 'omar.qahtani@student.edu.sa', 'hashed_password_here', 'student', 'U1002'),
('Fahad Al-Harbi', 'fahad.harbi@student.edu.sa', 'hashed_password_here', 'student', 'U1003'),
('Maha Al-Faisal', 'maha.faisal@student.edu.sa', 'hashed_password_here', 'student', 'U1004'),
('Nasser Al-Saif', 'nasser.saif@student.edu.sa', 'hashed_password_here', 'student', 'U1005'),
('Yousef Al-Otaibi', 'yousef.otaibi@student.edu.sa', 'hashed_password_here', 'student', 'U1006'),
('Hamad Al-Qahtani', 'hamad.qahtani@student.edu.sa', 'hashed_password_here', 'student', 'U1007'),
('Rakan Al-Fahad', 'rakan.fahad@student.edu.sa', 'hashed_password_here', 'student', 'U1008'),
('Hassan Al-Shahrani', 'hassan.shahrani@student.edu.sa', 'hashed_password_here', 'student', 'U1009'),
('Saud Al-Mutairi', 'saud.mutairi@student.edu.sa', 'hashed_password_here', 'student', 'U1010');

-- ==============================================
-- TABLE: Classes
-- ==============================================
CREATE TABLE classes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id INT NOT NULL,
    class_name VARCHAR(100) NOT NULL,
    academic_year VARCHAR(20),
    FOREIGN KEY (teacher_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Insert Classes
INSERT INTO classes (teacher_id, class_name, academic_year) VALUES
(2, 'Generative AI 101', '2025-2026'),
(3, 'Data Structures & Algorithms', '2025-2026');

-- ==============================================
-- TABLE: Generative AI Questions
-- ==============================================
CREATE TABLE generative_ai_questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    question_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ==============================================
-- TABLE: Generative AI Answers
-- ==============================================
CREATE TABLE generative_ai_answers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT NOT NULL,
    answer_text TEXT NOT NULL,
    FOREIGN KEY (question_id) REFERENCES generative_ai_questions(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ==============================================
-- TABLE: Generative AI Summaries
-- ==============================================
CREATE TABLE generative_ai_summaries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT NOT NULL,
    summary_text TEXT NOT NULL,
    FOREIGN KEY (question_id) REFERENCES generative_ai_questions(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ==============================================
-- TABLE: DSA Questions
-- ==============================================
CREATE TABLE dsa_questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    question_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ==============================================
-- TABLE: DSA Answers
-- ==============================================
CREATE TABLE dsa_answers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT NOT NULL,
    answer_text TEXT NOT NULL,
    FOREIGN KEY (question_id) REFERENCES dsa_questions(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ==============================================
-- TABLE: DSA Summaries
-- ==============================================
CREATE TABLE dsa_summaries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT NOT NULL,
    summary_text TEXT NOT NULL,
    FOREIGN KEY (question_id) REFERENCES dsa_questions(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ==============================================
-- TABLE: Notifications
-- ==============================================
CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    summary_id INT NOT NULL,
    type ENUM('generative_ai','dsa') NOT NULL,
    is_sent BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP NULL,
    FOREIGN KEY (student_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ==============================================
-- INSERT 50 Generative AI Questions, Answers & Summaries
-- ==============================================

-- Questions
INSERT INTO generative_ai_questions (class_id, question_text) VALUES
(1, 'What is the basic definition of Generative AI (GAI)?'),
(1, 'How does Generative AI differ from traditional AI?'),
(1, 'What are the four pillars that led to the evolution of modern generative models?'),
(1, 'When did the first phase (early generation) start in this field?'),
(1, 'What is the ELIZA chatbot and when was it created?'),
(1, 'What is the function of the SHRDLU program (1970)?'),
(1, 'Give an example of a program that generated digital artwork in the 1980s.'),
(1, 'What are Generative Adversarial Networks (GANs)?'),
(1, 'When was the Transformer architecture developed?'),
(1, 'What is the Attention mechanism in NLP?'),
(1, 'List three models that appeared during the post-2020 generative explosion.'),
(1, 'Which company developed ChatGPT?'),
(1, 'How does Generative AI help reduce workload?'),
(1, 'Explain the role of generative models in building educational content.'),
(1, 'Why is ChatGPT considered a turning point in public attention?'),
(1, 'What is Prompt Engineering?'),
(1, 'Mention two principles of effective prompt writing.'),
(1, 'What are Large Language Models (LLMs)?'),
(1, 'How can Generative AI be used in medicine?'),
(1, 'What are deepfake risks associated with this technology?'),
(1, 'Explain the concept of deep learning and its relation to the human brain.'),
(1, 'What is Machine Learning (ML)?'),
(1, 'How do open-source projects support AI development?'),
(1, 'What is the role of embeddings in understanding text?'),
(1, 'Give an example of Generative AI in cybersecurity.'),
(1, 'What are the disadvantages of generative models mentioned in the book?'),
(1, 'How does this technology contribute to digital games?'),
(1, 'What is the difference between extracted text and generated text?'),
(1, 'Explain the importance of big data in training models.'),
(1, 'What is Stable Diffusion and what type of networks does it use?'),
(1, 'How can generative models help in programming?'),
(1, 'What are the main ethical challenges in this field?'),
(1, 'Explain the use case of AI as a thinking assistant.'),
(1, 'Why is the Transformer architecture important for text data?'),
(1, 'How is the accuracy of LLMs evaluated?'),
(1, 'What is the role of logic and mathematics in AI training?'),
(1, 'Can Generative AI produce programming code?'),
(1, 'How does the evolution of computing hardware affect training efficiency?'),
(1, 'Mention a common challenge in prompt engineering.'),
(1, 'How does Generative AI serve the legal field?'),
(1, 'Explain the concept of brainstorming using AI.'),
(1, 'What is the relationship between AI and Machine Learning?'),
(1, 'What is the RACTER program (1983)?'),
(1, 'How does Generative AI contribute to journalism and media?'),
(1, 'What is the projected annual growth of the Generative AI market?'),
(1, 'Explain Diffusion Models.'),
(1, 'What are the benefits of using generative models in sales?'),
(1, 'How do generative models assist in content review and proofreading?'),
(1, 'What is meant by human-like responses?'),
(1, 'Explain the concept of AI in creative idea generation?');

-- Answers
INSERT INTO generative_ai_answers (question_id, answer_text) VALUES
(1, 'A branch of AI aimed at creating new and innovative content (text, images, audio) rather than just analyzing data.'),
(2, 'Traditional AI analyzes data and recognizes patterns, while Generative AI uses patterns to create entirely new data.'),
(3, 'Big data, advanced GPUs, Transformer architecture, and open-source projects.'),
(4, 'In the 1960s with simple rule-based and statistical programs.'),
(5, 'A chatbot simulating a psychotherapist, created by Joseph Weizenbaum in 1966.'),
(6, 'Understanding and processing natural language in a virtual block world.'),
(7, 'AARON program that generated digital art based on rules by Harold Cohen.'),
(8, 'Two competing networks (generator and discriminator) to improve content quality, introduced in 2014.'),
(9, 'In 2017 through the paper "Attention Is All You Need".'),
(10, 'A method that allows the model to focus on relevant parts of the input based on context.'),
(11, 'GPT-4, DALL-E 2, Stable Diffusion.'),
(12, 'OpenAI.'),
(13, 'Automates routine tasks, generates reports, and summarizes meetings.'),
(14, 'Creating curricula, generating tests, and simplifying complex concepts for students.'),
(15, 'Because of its natural conversational ability and wide availability.'),
(16, 'The art of crafting and optimizing text inputs to control model outputs precisely.'),
(17, 'Clarity and providing sufficient context.'),
(18, 'Models trained on massive datasets to predict words and understand human language.'),
(19, 'Analyzing medical images and generating hypotheses for new drugs quickly.'),
(20, 'Creating fake videos and audio for misinformation or impersonation.'),
(21, 'Part of ML using neural networks that mimic the brain\'s structure.'),
(22, 'Algorithms that allow computers to learn from data without explicit programming.'),
(23, 'Sharing models and code accelerates global innovation (e.g., Hugging Face).'),
(24, 'Converting words into multi-dimensional vectors to understand semantic meanings.'),
(25, 'Detecting code vulnerabilities and generating real-time alerts for cyberattacks.'),
(26, 'Bias and hallucination (producing false information confidently).'),
(27, 'Building vast worlds and intelligent dialogues with NPCs.'),
(28, 'Extracted text pulls existing facts, generated text creates entirely new content.'),
(29, 'Provides data to the model to understand human linguistic patterns.'),
(30, 'An image generation model based on diffusion networks.'),
(31, 'Generating programming code and assisting in debugging.'),
(32, 'Copyright, privacy, and data bias concerns.'),
(33, 'Using the model as a partner for brainstorming and draft creation.'),
(34, 'Ability to process long texts at once with high contextual accuracy.'),
(35, 'Through technical metrics (BLEU) or direct human evaluation.'),
(36, 'Used to represent and process data inside the neural network (linear algebra).'),
(37, 'Yes, it can write full functions in multiple programming languages.'),
(38, 'GPU speed reduced training time from months to a few days.'),
(39, 'Highly sensitive to word changes in the prompt.'),
(40, 'Summarizing legal cases and identifying loopholes.'),
(41, 'Generating ideas for titles, plans, or technical solutions.'),
(42, 'AI is the broader science; ML is one of its practical tools.'),
(43, 'Generated the first computer-written book in the 1980s.'),
(44, 'Generating news drafts based on incoming data.'),
(45, 'Projected to grow by billions of dollars in the coming years.'),
(46, 'Starts from random noise and progressively creates clear images.'),
(47, 'Customizes offers and messages automatically and accurately.'),
(48, 'Detecting language mistakes and suggesting better writing.'),
(49, 'Models can mimic human style to a level hard to distinguish.'),
(50, 'Providing human-like responses for chatbots and virtual assistants.');

-- Summaries
INSERT INTO generative_ai_summaries (question_id, summary_text) VALUES
(1, 'Generative AI creates content instead of only analyzing data.'),
(2, 'Focuses on producing new content, unlike traditional AI.'),
(3, 'Key elements: big data, GPUs, Transformers, open-source.'),
(4, 'Originated in the 1960s with simple programs.'),
(5, 'ELIZA simulated therapy conversations (1966).'),
(6, 'SHRDLU processed language in a virtual block world.'),
(7, 'AARON produced digital art in the 1980s.'),
(8, 'GANs: generator vs discriminator improves outputs.'),
(9, 'Transformers developed in 2017 (Attention paper).'),
(10, 'Attention helps models focus on important input parts.'),
(11, 'Notable models: GPT-4, DALL-E 2, Stable Diffusion.'),
(12, 'ChatGPT developed by OpenAI.'),
(13, 'Automates tasks and summarizes work.'),
(14, 'Generates curricula, tests, and simplifies learning.'),
(15, 'ChatGPT popular due to conversational ability.'),
(16, 'Prompt engineering crafts effective model inputs.'),
(17, 'Effective prompts need clarity and context.'),
(18, 'LLMs trained on huge datasets understand language.'),
(19, 'Medical image analysis and drug hypotheses.'),
(20, 'Deepfakes can produce misleading media.'),
(21, 'Deep learning mimics brain neural structures.'),
(22, 'ML enables learning without explicit coding.'),
(23, 'Open-source accelerates AI innovation.'),
(24, 'Embeddings convert words to vectors for meaning.'),
(25, 'Detects vulnerabilities in real-time.'),
(26, 'Main risks: bias and hallucinations.'),
(27, 'Used in game worlds and NPC interactions.'),
(28, 'Extracted vs generated text differs in originality.'),
(29, 'Embeddings help models understand text patterns.'),
(30, 'Stable Diffusion uses diffusion networks for images.'),
(31, 'Generates and debugs code.'),
(32, 'Ethical concerns: copyright, privacy, bias.'),
(33, 'Helps brainstorming and drafting ideas.'),
(34, 'Handles long text with high context accuracy.'),
(35, 'Evaluated via BLEU metrics or human review.'),
(36, 'Linear algebra used internally in neural networks.'),
(37, 'Can write functions in multiple languages.'),
(38, 'GPU advancements sped up training.'),
(39, 'Prompt wording affects output significantly.'),
(40, 'Summarizes legal cases effectively.'),
(41, 'Generates technical ideas and plans.'),
(42, 'AI is broader; ML is a tool within AI.'),
(43, 'First computer-written book in 1980s.'),
(44, 'Drafts news articles from incoming data.'),
(45, 'Market projected to grow billions in coming years.'),
(46, 'Diffusion models create images from noise.'),
(47, 'Personalizes messages and offers.'),
(48, 'Assists in improving written text.'),
(49, 'Mimics human style convincingly.'),
(50, 'Provides human-like chatbot responses.');

-- ==============================================
-- INSERT 50 DSA Questions, Answers & Summaries
-- ==============================================

-- Questions
INSERT INTO dsa_questions (class_id, question_text) VALUES
(2, 'What is a data structure?'),
(2, 'What are the types of data structures?'),
(2, 'Define an array.'),
(2, 'What is a linked list?'),
(2, 'Difference between singly and doubly linked lists.'),
(2, 'What is a stack?'),
(2, 'Explain the concept of a queue.'),
(2, 'Difference between queue and stack.'),
(2, 'What is a circular queue?'),
(2, 'Define a binary tree.'),
(2, 'What is a binary search tree (BST)?'),
(2, 'Explain tree traversal methods.'),
(2, 'What is a graph?'),
(2, 'Types of graphs.'),
(2, 'Explain adjacency list vs adjacency matrix.'),
(2, 'What is a hash table?'),
(2, 'Collision resolution methods in hashing.'),
(2, 'Explain the concept of a heap.'),
(2, 'Difference between min-heap and max-heap.'),
(2, 'What is recursion in algorithms?'),
(2, 'Explain time complexity.'),
(2, 'Explain space complexity.'),
(2, 'Big O notation basics.'),
(2, 'What is searching?'),
(2, 'Linear search algorithm.'),
(2, 'Binary search algorithm.'),
(2, 'What is sorting?'),
(2, 'Explain bubble sort.'),
(2, 'Explain selection sort.'),
(2, 'Explain insertion sort.'),
(2, 'What is merge sort?'),
(2, 'What is quick sort?'),
(2, 'Explain depth-first search (DFS).'),
(2, 'Explain breadth-first search (BFS).'),
(2, 'What is dynamic programming?'),
(2, 'What is greedy algorithm?'),
(2, 'What is divide and conquer strategy?'),
(2, 'Explain backtracking.'),
(2, 'What is a priority queue?'),
(2, 'Applications of stacks.'),
(2, 'Applications of queues.'),
(2, 'Applications of trees.'),
(2, 'Applications of graphs.'),
(2, 'What is the difference between directed and undirected graph?'),
(2, 'What is a cycle in a graph?'),
(2, 'What is topological sorting?'),
(2, 'Explain Dijkstra\'s algorithm.'),
(2, 'Explain Kruskal\'s algorithm.'),
(2, 'Explain Prim\'s algorithm.'),
(2, 'Explain the concept of amortized analysis.');

-- Answers
INSERT INTO dsa_answers (question_id, answer_text) VALUES
(1, 'A data structure is a way to organize, manage, and store data for efficient access and modification.'),
(2, 'Data structures are categorized as primitive (int, float, char) and non-primitive (arrays, lists, trees, graphs).'),
(3, 'An array is a collection of elements identified by index or key, stored in contiguous memory.'),
(4, 'A linked list is a collection of nodes where each node contains data and a reference to the next node.'),
(5, 'Singly linked list has one pointer per node; doubly linked list has two pointers (next and previous).'),
(6, 'A stack is a linear data structure following LIFO (Last In, First Out) principle.'),
(7, 'A queue is a linear data structure following FIFO (First In, First Out) principle.'),
(8, 'Stack uses LIFO; Queue uses FIFO.'),
(9, 'Circular queue is a queue where the last position is connected back to the first to utilize storage efficiently.'),
(10, 'A binary tree is a hierarchical structure with nodes having at most two children.'),
(11, 'BST is a binary tree where left child < parent < right child, enabling efficient search.'),
(12, 'Traversals: Inorder, Preorder, Postorder, Level order.'),
(13, 'A graph is a collection of vertices (nodes) and edges connecting pairs of vertices.'),
(14, 'Graphs can be directed, undirected, weighted, or unweighted.'),
(15, 'Adjacency list stores only neighbors for each vertex; adjacency matrix uses a 2D array for edges.'),
(16, 'Hash table maps keys to values for fast access using a hash function.'),
(17, 'Collisions handled by chaining (linked list) or open addressing (linear probing, double hashing).'),
(18, 'A heap is a complete binary tree satisfying heap property (min-heap or max-heap).'),
(19, 'Min-heap: parent ≤ children; Max-heap: parent ≥ children.'),
(20, 'Recursion is a method where a function calls itself to solve smaller subproblems.'),
(21, 'Time complexity measures how execution time increases with input size.'),
(22, 'Space complexity measures memory used as a function of input size.'),
(23, 'Big O notation describes the upper bound of algorithm complexity.'),
(24, 'Searching is the process of finding a target element within a data structure.'),
(25, 'Linear search checks each element sequentially until target is found.'),
(26, 'Binary search divides sorted data in half repeatedly to locate the target.'),
(27, 'Sorting arranges data in a particular order, ascending or descending.'),
(28, 'Bubble sort repeatedly swaps adjacent elements if they are in wrong order.'),
(29, 'Selection sort selects the smallest element and swaps it to correct position iteratively.'),
(30, 'Insertion sort builds the sorted array one element at a time.'),
(31, 'Merge sort divides array recursively, sorts halves, and merges them.'),
(32, 'Quick sort partitions array around a pivot and sorts subarrays recursively.'),
(33, 'DFS explores as far as possible along each branch before backtracking.'),
(34, 'BFS explores all neighbors at current depth before moving deeper.'),
(35, 'Dynamic programming solves problems by breaking into overlapping subproblems and storing results.'),
(36, 'Greedy algorithms make the locally optimal choice at each step.'),
(37, 'Divide and conquer splits problem into smaller parts, solves them, then combines results.'),
(38, 'Backtracking explores all possible solutions and abandons paths that fail constraints.'),
(39, 'Priority queue is a queue where elements are dequeued based on priority, not order.'),
(40, 'Stacks used in undo, expression evaluation, recursion tracking.'),
(41, 'Queues used in scheduling, buffering, and BFS traversal.'),
(42, 'Trees used in hierarchical data, databases, and file systems.'),
(43, 'Graphs used in networks, maps, social connections, routing.'),
(44, 'Directed graph has edges with direction; undirected has no direction.'),
(45, 'Cycle is a path starting and ending at same vertex.'),
(46, 'Topological sorting orders vertices in a DAG such that for every edge u→v, u comes before v.'),
(47, 'Dijkstra computes shortest path from source to all vertices in weighted graph.'),
(48, 'Kruskal finds minimum spanning tree by adding edges in increasing weight order.'),
(49, 'Prim grows MST by adding nearest vertex to current tree iteratively.'),
(50, 'Amortized analysis averages worst-case costs over a sequence of operations.');

-- Summaries
INSERT INTO dsa_summaries (question_id, summary_text) VALUES
(1, 'DS stores and organizes data efficiently.'),
(2, 'Primitive vs non-primitive DS.'),
(3, 'Array: indexed collection in memory.'),
(4, 'Linked list: nodes connected via pointers.'),
(5, 'Singly: one pointer; Doubly: two pointers.'),
(6, 'Stack: LIFO structure.'),
(7, 'Queue: FIFO structure.'),
(8, 'Stack LIFO, Queue FIFO.'),
(9, 'Circular queue loops end to start.'),
(10, 'Binary tree: node with max two children.'),
(11, 'BST: left<parent<right for search.'),
(12, 'Traversals: Inorder, Preorder, Postorder, Level.'),
(13, 'Graph: vertices + edges.'),
(14, 'Graph types: directed, undirected, weighted.'),
(15, 'Adjacency list vs matrix.'),
(16, 'Hash table maps keys to values.'),
(17, 'Collisions: chaining or open addressing.'),
(18, 'Heap: complete tree with min/max property.'),
(19, 'Min-heap ≤ children; Max-heap ≥ children.'),
(20, 'Recursion: function calls itself.'),
(21, 'Time complexity: execution vs input.'),
(22, 'Space complexity: memory vs input.'),
(23, 'Big O: upper bound of complexity.'),
(24, 'Searching: locate element in DS.'),
(25, 'Linear search: sequential check.'),
(26, 'Binary search: divide sorted data.'),
(27, 'Sorting: arranging data.'),
(28, 'Bubble sort: swap adjacent.'),
(29, 'Selection sort: select min each pass.'),
(30, 'Insertion sort: build sorted array incrementally.'),
(31, 'Merge sort: divide, sort, merge.'),
(32, 'Quick sort: pivot partitioning.'),
(33, 'DFS: explore branch deeply.'),
(34, 'BFS: explore level by level.'),
(35, 'DP: store subproblem results.'),
(36, 'Greedy: locally optimal choice.'),
(37, 'Divide and conquer: split, solve, combine.'),
(38, 'Backtracking: explore all possibilities.'),
(39, 'Priority queue: dequeue by priority.'),
(40, 'Stacks: undo, eval, recursion.'),
(41, 'Queues: scheduling, BFS, buffering.'),
(42, 'Trees: hierarchy, DB, filesystem.'),
(43, 'Graphs: networks, maps, social.'),
(44, 'Directed vs undirected edges.'),
(45, 'Cycle: path ends at start.'),
(46, 'Topological sort: DAG vertex ordering.'),
(47, 'Dijkstra: shortest paths.'),
(48, 'Kruskal: MST by edges.'),
(49, 'Prim: MST by nearest vertex.'),
(50, 'Amortized analysis: average cost over operations.');


-- =================================================
-- 1. Additional Constraints
-- =================================================
ALTER TABLE users
MODIFY student_number VARCHAR(20) UNIQUE,  -- student number must be unique
MODIFY full_name VARCHAR(100) NOT NULL;

-- =================================================
-- 2. Additional Indexes for Performance
-- =================================================
CREATE INDEX idx_student_number ON users(student_number);
CREATE INDEX idx_class_id_gai ON generative_ai_questions(class_id);
CREATE INDEX idx_class_id_dsa ON dsa_questions(class_id);

-- =================================================
-- 3. Audit Fields for important tables
-- =================================================
ALTER TABLE generative_ai_questions
ADD COLUMN created_by INT NULL,
ADD COLUMN updated_by INT NULL,
ADD FOREIGN KEY (created_by) REFERENCES users(id),
ADD FOREIGN KEY (updated_by) REFERENCES users(id);

ALTER TABLE dsa_questions
ADD COLUMN created_by INT NULL,
ADD COLUMN updated_by INT NULL,
ADD FOREIGN KEY (created_by) REFERENCES users(id),
ADD FOREIGN KEY (updated_by) REFERENCES users(id);

-- =================================================
-- 4. Roles and Permissions tables (optional for advanced system)
-- =================================================
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO roles (role_name) VALUES ('admin'), ('teacher'), ('student');

CREATE TABLE permissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    table_name VARCHAR(100) NOT NULL,
    can_create BOOLEAN DEFAULT FALSE,
    can_read BOOLEAN DEFAULT FALSE,
    can_update BOOLEAN DEFAULT FALSE,
    can_delete BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
);

-- =================================================
-- 5. Activity Logs table to track user actions
-- =================================================
CREATE TABLE activity_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    action VARCHAR(255) NOT NULL,
    table_name VARCHAR(100),
    record_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- =================================================
-- 6. Password Hashing
-- =================================================
-- Note: Passwords should be hashed in the application layer (e.g., bcrypt) before inserting into the database.
-- Example: UPDATE users SET password_hash = 'bcrypt_hashed_value' WHERE id = 1;

-- ==============================================
-- 1. Table: Student Classes (many-to-many)
-- ==============================================
CREATE TABLE student_classes (
    student_id INT NOT NULL,
    class_id INT NOT NULL,
    PRIMARY KEY(student_id, class_id),
    FOREIGN KEY(student_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(class_id) REFERENCES classes(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ==============================================
-- 2. Add created_by / updated_by to Answers & Summaries
-- ==============================================
ALTER TABLE generative_ai_answers
ADD COLUMN created_by INT NULL,
ADD COLUMN updated_by INT NULL,
ADD FOREIGN KEY (created_by) REFERENCES users(id),
ADD FOREIGN KEY (updated_by) REFERENCES users(id);

ALTER TABLE generative_ai_summaries
ADD COLUMN created_by INT NULL,
ADD COLUMN updated_by INT NULL,
ADD FOREIGN KEY (created_by) REFERENCES users(id),
ADD FOREIGN KEY (updated_by) REFERENCES users(id);

ALTER TABLE dsa_answers
ADD COLUMN created_by INT NULL,
ADD COLUMN updated_by INT NULL,
ADD FOREIGN KEY (created_by) REFERENCES users(id),
ADD FOREIGN KEY (updated_by) REFERENCES users(id);

ALTER TABLE dsa_summaries
ADD COLUMN created_by INT NULL,
ADD COLUMN updated_by INT NULL,
ADD FOREIGN KEY (created_by) REFERENCES users(id),
ADD FOREIGN KEY (updated_by) REFERENCES users(id);

-- ==============================================
-- 3. Update Notifications table
-- ==============================================
ALTER TABLE notifications
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- FK cannot directly reference two different tables based on type
-- Alternative: optional, just keep summary_id as INT and ensure logic in app layer

-- ==============================================
-- 4. Additional Indexes
-- ==============================================
CREATE INDEX idx_student_classes_student ON student_classes(student_id);
CREATE INDEX idx_student_classes_class ON student_classes(class_id);

CREATE INDEX idx_gai_answers_question ON generative_ai_answers(question_id);
CREATE INDEX idx_gai_summaries_question ON generative_ai_summaries(question_id);
CREATE INDEX idx_dsa_answers_question ON dsa_answers(question_id);
CREATE INDEX idx_dsa_summaries_question ON dsa_summaries(question_id);

-- =================================================
-- Notifications tables separated by type
-- =================================================

-- Table for notifications related to Generative AI summaries
CREATE TABLE notifications_gai (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    summary_id INT NOT NULL,
    is_sent BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP NULL,
    -- Foreign key to the student
    FOREIGN KEY (student_id) REFERENCES users(id),
    -- Foreign key to the Generative AI summary
    FOREIGN KEY (summary_id) REFERENCES generative_ai_summaries(id)
);

-- Table for notifications related to DSA summaries
CREATE TABLE notifications_dsa (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    summary_id INT NOT NULL,
    is_sent BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP NULL,
    -- Foreign key to the student
    FOREIGN KEY (student_id) REFERENCES users(id),
    -- Foreign key to the DSA summary
    FOREIGN KEY (summary_id) REFERENCES dsa_summaries(id)
);

-- =================================================
-- Add updated_at columns to answers and summaries
-- =================================================
-- These columns will automatically update on record modification

ALTER TABLE generative_ai_answers 
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE generative_ai_summaries 
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE dsa_answers 
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE dsa_summaries 
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- =================================================
-- Sample notifications insertion
-- =================================================
-- This is an example of linking students to summaries for notifications

INSERT INTO notifications (student_id, summary_id, type) VALUES
(5, 1, 'generative_ai'),
(6, 12, 'generative_ai'),
(7, 25, 'dsa'),
(8, 30, 'dsa');

-- =================================================
-- Indexes for created_by columns to improve query performance
-- =================================================

CREATE INDEX idx_gai_answers_created_by 
ON generative_ai_answers(created_by);

CREATE INDEX idx_gai_summaries_created_by 
ON generative_ai_summaries(created_by);

CREATE INDEX idx_dsa_answers_created_by 
ON dsa_answers(created_by);

CREATE INDEX idx_dsa_summaries_created_by 
ON dsa_summaries(created_by);

-- =================================================
-- 7. Course Materials (Books / Chapters Upload)
-- =================================================
CREATE TABLE materials (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    file_type ENUM('book','chapter','slides','pdf') NOT NULL,
    file_path VARCHAR(500) NOT NULL,
    uploaded_by INT NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE,
    FOREIGN KEY (uploaded_by) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_material_class ON materials(class_id);


-- =================================================
-- 8. Material Chunks (For RAG Search System)
-- =================================================
CREATE TABLE material_chunks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    material_id INT NOT NULL,
    chunk_text TEXT NOT NULL,
    chunk_order INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (material_id) REFERENCES materials(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_chunk_material ON material_chunks(material_id);


-- =================================================
-- 9. Lectures (Lecture Recording System)
-- =================================================
CREATE TABLE lectures (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    recording_url VARCHAR(500),
    lecture_date DATETIME NOT NULL,
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_lecture_class ON lectures(class_id);


-- =================================================
-- 10. AI Live Questions (Teacher asks AI directly)
-- =================================================
CREATE TABLE ai_live_questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    teacher_id INT NOT NULL,
    question_text TEXT NOT NULL,
    ai_response TEXT,
    asked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_ai_live_class ON ai_live_questions(class_id);

-- =================================================
-- 11. AI Retrieved Chunks (RAG References)
-- =================================================
CREATE TABLE ai_retrieved_chunks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ai_question_id INT NOT NULL,
    chunk_id INT NOT NULL,
    relevance_score DECIMAL(5,2),

    FOREIGN KEY (ai_question_id) REFERENCES ai_live_questions(id) ON DELETE CASCADE,
    FOREIGN KEY (chunk_id) REFERENCES material_chunks(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_ai_question_chunks ON ai_retrieved_chunks(ai_question_id);
